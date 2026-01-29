use pact_consumer::prelude::{DateTime, EachLike, JsonPattern, Like, StringPattern, Term};
use regex::Regex;
use rustler::{Atom, Decoder, Encoder, NifTaggedEnum, NifUntaggedEnum};
use std::collections::HashMap;

mod atoms {
    rustler::atoms! {
        invalid_json_object_key
    }
}

#[derive(PartialEq, Eq, Hash)]
pub struct JsonObjectKey(String);

impl<'a> Decoder<'a> for JsonObjectKey {
    fn decode(term: rustler::Term<'a>) -> rustler::NifResult<Self> {
        if term.is_atom() {
            Ok(JsonObjectKey(term.atom_to_string()?))
        } else if term.is_binary() {
            match String::from_utf8(term.decode_as_binary()?.as_slice().to_vec()) {
                Ok(s) => Ok(JsonObjectKey(s)),
                Err(e) => Err(rustler::Error::Term(Box::new((
                    atoms::invalid_json_object_key(),
                    format!("Invalid UTF-8 in binary: {}", e),
                )))),
            }
        } else {
            Err(rustler::Error::Term(Box::new((
                atoms::invalid_json_object_key(),
                "Term is neither atom nor binary".to_string(),
            ))))
        }
    }
}

impl Encoder for JsonObjectKey {
    fn encode<'a>(&self, env: rustler::Env<'a>) -> rustler::Term<'a> {
        rustler::Encoder::encode(&self, env)
    }
}

#[derive(NifUntaggedEnum)]
pub enum NifJsonPattern {
    String(String),
    Number(f64),
    Bool(bool),
    Array(Vec<NifJsonPattern>),
    Null(Atom),
    Object(HashMap<JsonObjectKey, NifJsonPattern>),
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
                .map(|(k, v)| (k.0, v.into()))
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
