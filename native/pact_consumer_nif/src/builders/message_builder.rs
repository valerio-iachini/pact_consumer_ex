use pact_consumer::builders::MessageInteractionBuilder;
use rustler::{NifResult, NifStruct, Resource, ResourceArc};
use std::sync::Mutex;

use crate::{
    impl_builder_nif,
    models::interaction::{InteractionResource, NifInteraction},
    patterns::NifJsonPattern,
};

#[derive(NifStruct)]
#[module = "MessageInteractionBuilder"]
pub struct NifMessageInteractionBuilder {
    inner: ResourceArc<MessageInteractionBuilderResource>,
}

pub struct MessageInteractionBuilderResource(Mutex<MessageInteractionBuilder>);

impl NifMessageInteractionBuilder {
    fn invoke<F, T>(&self, fun: F) -> NifResult<T>
    where
        F: FnOnce(&mut MessageInteractionBuilder) -> NifResult<T>,
    {
        let mut inner = self
            .inner
            .0
            .lock()
            .map_err(|_e| rustler::Error::RaiseAtom("invalid_message_builder_reference"))?;

        fun(&mut inner)
    }
}

impl Resource for MessageInteractionBuilderResource {}

#[rustler::nif(name = "message_builder_new")]
pub fn new(description: String) -> NifMessageInteractionBuilder {
    NifMessageInteractionBuilder {
        inner: ResourceArc::new(MessageInteractionBuilderResource(Mutex::new(
            MessageInteractionBuilder::new(description),
        ))),
    }
}

#[rustler::nif(name = "message_builder_given_with_params")]
pub fn given_with_params(
    builder: NifMessageInteractionBuilder,
    given: String,
    params: String,
) -> NifResult<NifMessageInteractionBuilder> {
    builder.invoke(|b| {
        let params: serde_json::Value = serde_json::from_str(&params)
            .map_err(|_e| rustler::Error::RaiseAtom("invalid_params"))?;

        b.given_with_params(given, &params);
        Ok(())
    })?;

    Ok(builder)
}

#[rustler::nif(name = "message_builder_build")]
pub fn build(builder: NifMessageInteractionBuilder) -> NifResult<NifInteraction> {
    let interaction = builder.invoke(|b| Ok(b.build()))?;

    Ok(NifInteraction {
        inner: ResourceArc::new(InteractionResource(Box::new(interaction))),
    })
}

impl_builder_nif!("message_builder_with_key", NifMessageInteractionBuilder, with_key(key: String));
impl_builder_nif!("message_builder_pending", NifMessageInteractionBuilder, pending(value: bool));
impl_builder_nif!("message_builder_given", NifMessageInteractionBuilder, given(value: String));
impl_builder_nif!("message_builder_comment", NifMessageInteractionBuilder, comment(value: String));
impl_builder_nif!("message_builder_test_name", NifMessageInteractionBuilder, test_name(name: String));
impl_builder_nif!("message_builder_json_body", NifMessageInteractionBuilder, json_body(body: NifJsonPattern));
