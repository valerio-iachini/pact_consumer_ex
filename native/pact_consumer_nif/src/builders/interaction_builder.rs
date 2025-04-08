use crate::builders::request_builder::NifRequestBuilder;
use crate::builders::response_builder::NifResponseBuilder;
use crate::impl_builder_nif;
use crate::models::interaction::InteractionResource;
use crate::models::interaction::NifInteraction;
use pact_consumer::builders::InteractionBuilder;
use rustler::{NifResult, NifStruct, Resource, ResourceArc};
use std::sync::Mutex;

#[derive(NifStruct)]
#[module = "InteractionBuilder"]
pub struct NifInteractionBuilder {
    inner: ResourceArc<InteractionBuilderResource>,
}

pub struct InteractionBuilderResource(Mutex<InteractionBuilder>);

impl NifInteractionBuilder {
    fn invoke<F, T>(&self, fun: F) -> NifResult<T>
    where
        F: FnOnce(&mut InteractionBuilder) -> NifResult<T>,
    {
        let mut inner = self
            .inner
            .0
            .lock()
            .map_err(|_e| rustler::Error::RaiseAtom("invalid_interaction_builder_reference"))?;

        fun(&mut inner)
    }
}

impl Resource for InteractionBuilderResource {}

#[rustler::nif(name = "interaction_builder_new")]
pub fn new(description: String, interaction_type: String) -> NifInteractionBuilder {
    NifInteractionBuilder {
        inner: ResourceArc::new(InteractionBuilderResource(Mutex::new(
            InteractionBuilder::new(description, interaction_type),
        ))),
    }
}

#[rustler::nif(name = "interaction_builder_given_with_params")]
pub fn given_with_params(
    builder: NifInteractionBuilder,
    given: String,
    params: String,
) -> NifResult<NifInteractionBuilder> {
    builder.invoke(|b| {
        let params: serde_json::Value = serde_json::from_str(&params)
            .map_err(|_e| rustler::Error::RaiseAtom("invalid_params"))?;

        b.given_with_params(given, &params);
        Ok(())
    })?;

    Ok(builder)
}

#[rustler::nif(name = "interaction_builder_request")]
pub fn request(
    builder: NifInteractionBuilder,
    request_builder: NifRequestBuilder,
) -> NifResult<NifInteractionBuilder> {
    builder.invoke(|b| {
        b.request = request_builder.0.lock().unwrap().clone();
        Ok(())
    })?;
    Ok(builder)
}

#[rustler::nif(name = "interaction_builder_response")]
pub fn response(
    builder: NifInteractionBuilder,
    response_builder: NifResponseBuilder,
) -> NifResult<NifInteractionBuilder> {
    builder.invoke(|b| {
        b.response = response_builder.0.lock().unwrap().clone();
        Ok(())
    })?;
    Ok(builder)
}

#[rustler::nif(name = "interaction_builder_build")]
pub fn build(builder: NifInteractionBuilder) -> NifResult<NifInteraction> {
    let interaction = builder.invoke(|b| Ok(b.build()))?;

    Ok(NifInteraction {
        inner: ResourceArc::new(InteractionResource(Box::new(interaction))),
    })
}

#[rustler::nif(name = "interaction_builder_build_v4")]
pub fn build_v4(builder: NifInteractionBuilder) -> NifResult<NifInteraction> {
    let interaction = builder.invoke(|b| Ok(b.build_v4()))?;

    Ok(NifInteraction {
        inner: ResourceArc::new(InteractionResource(Box::new(interaction))),
    })
}

impl_builder_nif!("interaction_builder_with_key", NifInteractionBuilder, with_key(key: String));
impl_builder_nif!("interaction_builder_pending", NifInteractionBuilder, pending(value: bool));
impl_builder_nif!("interaction_builder_given", NifInteractionBuilder, given(value: String));
impl_builder_nif!("interaction_builder_comment", NifInteractionBuilder, comment(value: String));
impl_builder_nif!("interaction_builder_test_name", NifInteractionBuilder, test_name(value: String));
impl_builder_nif!("interaction_builder_transport", NifInteractionBuilder, transport(name: String));
