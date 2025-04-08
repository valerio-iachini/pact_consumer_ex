use pact_consumer::prelude::PactBuilder;
use rustler::{NifResult, NifStruct, Resource, ResourceArc};
use std::sync::Mutex;

use crate::models::{
    interaction::NifInteraction,
    v4::async_message::{AsynchronousMessageResource, NifAsynchronousMessage},
};

#[derive(NifStruct)]
#[module = "PactBuilder"]
pub struct NifPactBuilder {
    inner: ResourceArc<PactBuilderResource>,
    is_v4: bool,
}

pub struct PactBuilderResource(Mutex<PactBuilder>);

impl NifPactBuilder {
    fn new(consumer: String, provider: String) -> Self {
        Self {
            inner: ResourceArc::new(PactBuilderResource(Mutex::new(PactBuilder::new(
                consumer, provider,
            )))),
            is_v4: false,
        }
    }

    fn new_v4(consumer: String, provider: String) -> Self {
        Self {
            inner: ResourceArc::new(PactBuilderResource(Mutex::new(PactBuilder::new_v4(
                consumer, provider,
            )))),
            is_v4: true,
        }
    }
}

impl NifPactBuilder {
    pub fn invoke<F, T>(&self, fun: F) -> NifResult<T>
    where
        F: FnOnce(&mut PactBuilder) -> NifResult<T>,
    {
        let mut inner = self
            .inner
            .0
            .lock()
            .map_err(|_e| rustler::Error::RaiseAtom("invalid_pact_builder_reference"))?;

        fun(&mut inner)
    }
}

impl Resource for PactBuilderResource {}

#[rustler::nif(name = "pact_builder_new")]
fn new(consumer: String, provider: String) -> NifPactBuilder {
    NifPactBuilder::new(consumer, provider)
}

#[rustler::nif(name = "pact_builder_new_v4")]
fn new_v4(consumer: String, provider: String) -> NifPactBuilder {
    NifPactBuilder::new_v4(consumer, provider)
}

#[rustler::nif(name = "pact_builder_is_v4")]
fn is_v4(builder: NifPactBuilder) -> bool {
    builder.is_v4
}

#[rustler::nif(name = "pact_builder_push_interaction")]
fn push_interaction(
    builder: NifPactBuilder,
    interaction: NifInteraction,
) -> NifResult<NifPactBuilder> {
    builder.invoke(|b| {
        b.push_interaction(&(*interaction.inner.0));
        Ok(())
    })?;

    Ok(builder)
}

#[rustler::nif(name = "pact_builder_messages")]
fn messages(builder: NifPactBuilder) -> NifResult<Vec<NifAsynchronousMessage>> {
    builder.invoke(|b| {
        Ok(b.messages()
            .map(|am| NifAsynchronousMessage {
                inner: ResourceArc::new(AsynchronousMessageResource(am)),
            })
            .collect())
    })
}
