use pact_consumer::prelude::{DateTime, EachLike, JsonPattern, Like, StringPattern, Term};
use regex::Regex;
use rustler::{Atom, NifTaggedEnum, NifUntaggedEnum};
use std::collections::HashMap;

#[derive(NifUntaggedEnum)]
pub enum NifJsonPattern {
    String(String),
    Number(f64),
    Bool(bool),
    Array(Vec<NifJsonPattern>),
    Null(Atom),
    Object(HashMap<String, NifJsonPattern>),
    Matcher(NifJsonMatcher),
}

#[derive(NifTaggedEnum)]
pub enum NifJsonMatcher {
    MatchingRegex {
        regex: String,
        example: String,
    },
    Like(Box<NifJsonPattern>),
    EachLike {
        json_pattern: Box<NifJsonPattern>,
        min_len: usize,
    },
    DateTime {
        format: String,
        example: String,
    },
}

impl From<NifJsonPattern> for JsonPattern {
    fn from(value: NifJsonPattern) -> Self {
        match value {
            NifJsonPattern::String(string) => string.into(),
            NifJsonPattern::Number(number) => number.into(),
            NifJsonPattern::Bool(bool) => bool.into(),
            NifJsonPattern::Array(array) => array
                .into_iter()
                .map(Into::into)
                .collect::<Vec<JsonPattern>>()
                .into(),
            NifJsonPattern::Object(object) => object
                .into_iter()
                .map(|(k, v)| (k, v.into()))
                .collect::<HashMap<String, JsonPattern>>()
                .into(),
            NifJsonPattern::Matcher(matcher) => matcher.into(),
            NifJsonPattern::Null(_atom) => JsonPattern::null(),
        }
    }
}

impl From<NifJsonMatcher> for JsonPattern {
    fn from(value: NifJsonMatcher) -> Self {
        match value {
            NifJsonMatcher::MatchingRegex { regex, example } => {
                Term::<JsonPattern>::new(Regex::new(&regex).expect("valid regex"), example).into()
            }
            NifJsonMatcher::Like(json_pattern) => {
                Like::<JsonPattern>::new::<JsonPattern>((*json_pattern).into()).into()
            }
            NifJsonMatcher::EachLike {
                json_pattern,
                min_len,
            } => EachLike::new((*json_pattern).into())
                .with_min_len(min_len)
                .into(),
            NifJsonMatcher::DateTime { format, example } => {
                DateTime::<JsonPattern>::new(format, example).into()
            }
        }
    }
}

#[derive(NifUntaggedEnum)]
pub enum NifStringPattern {
    /// A literal string, which matches and generates itself.
    String(String),
    /// A nested pattern.
    Matcher(NifStringMatcher),
}

#[derive(NifTaggedEnum)]
pub enum NifStringMatcher {
    MatchingRegex { regex: String, example: String },
    Like(Box<NifStringPattern>),
    DateTime { format: String, example: String },
}

impl From<NifStringPattern> for StringPattern {
    fn from(value: NifStringPattern) -> Self {
        match value {
            NifStringPattern::String(string) => string.into(),
            NifStringPattern::Matcher(matcher) => matcher.into(),
        }
    }
}

impl From<NifStringMatcher> for StringPattern {
    fn from(value: NifStringMatcher) -> Self {
        match value {
            NifStringMatcher::MatchingRegex { regex, example } => {
                Term::<StringPattern>::new(Regex::new(&regex).expect("valid regex"), example).into()
            }
            NifStringMatcher::Like(pattern) => {
                Like::<StringPattern>::new::<StringPattern>((*pattern).into()).into()
            }
            NifStringMatcher::DateTime { format, example } => {
                DateTime::<StringPattern>::new(format, example).into()
            }
        }
    }
}
