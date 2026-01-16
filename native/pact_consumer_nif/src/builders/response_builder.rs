use crate::{
    impl_builder_nif,
    models::{
        response::{NifResponse, ResponseResource},
        v4::http_parts::{HttpResponseResource, NifHttpResponse},
    },
    patterns::NifStringPattern,
};
use pact_consumer::{builders::ResponseBuilder, prelude::HttpPartBuilder};
use rustler::{NifResult, NifStruct, Resource, ResourceArc};
use std::{ops::Deref, sync::Mutex};
use tokio::runtime::Runtime;

#[derive(NifStruct)]
#[module = "ResponseBuilder"]
pub struct NifResponseBuilder {
    inner: ResourceArc<ResponseBuilderResource>,
}

impl Deref for NifResponseBuilder {
    type Target = ResponseBuilderResource;

    fn deref(&self) -> &Self::Target {
        &self.inner
    }
}

pub struct ResponseBuilderResource(pub Mutex<ResponseBuilder>);

impl NifResponseBuilder {
    fn invoke<F, T>(&self, fun: F) -> NifResult<T>
    where
        F: FnOnce(&mut ResponseBuilder) -> NifResult<T>,
    {
        let mut inner = self
            .inner
            .0
            .lock()
            .map_err(|_e| rustler::Error::RaiseAtom("invalid_response_reference"))?;

        fun(&mut inner)
    }

    pub fn invoke_async<F, T>(&self, fun: F) -> NifResult<T>
    where
        F: AsyncFnOnce(&mut ResponseBuilder) -> NifResult<T>,
    {
        let mut inner = self
            .inner
            .0
            .lock()
            .map_err(|_e| rustler::Error::RaiseAtom("invalid_pact_builder_reference"))?;
        let rt = Runtime::new().unwrap();
        rt.block_on(async { fun(&mut inner).await })
    }
}

impl Resource for ResponseBuilderResource {}

#[rustler::nif(name = "response_builder_default")]
pub fn default() -> NifResponseBuilder {
    NifResponseBuilder {
        inner: ResourceArc::new(ResponseBuilderResource(Mutex::new(
            ResponseBuilder::default(),
        ))),
    }
}

#[rustler::nif(name = "response_builder_build")]
pub fn build(builder: NifResponseBuilder) -> NifResult<NifResponse> {
    builder.invoke(|b| {
        Ok(NifResponse {
            inner: ResourceArc::new(ResponseResource(b.build())),
        })
    })
}

#[rustler::nif(name = "response_builder_build_v4")]
pub fn build_v4(builder: NifResponseBuilder) -> NifResult<NifHttpResponse> {
    builder.invoke(|b| {
        Ok(NifHttpResponse {
            inner: ResourceArc::new(HttpResponseResource(b.build_v4())),
        })
    })
}

#[rustler::nif(name = "response_builder_contents", schedule = "DirtyIo")]
pub fn contents(
    builder: NifResponseBuilder,
    content_type: String,
    definition: String,
) -> NifResult<NifResponseBuilder> {
    builder.invoke_async(async move |b| {
        let definition: serde_json::Value = serde_json::from_str(&definition)
            .map_err(|_e| rustler::Error::RaiseAtom("invalid_definition"))?;
        b.contents(
            content_type
                .parse()
                .map_err(|_| rustler::Error::RaiseAtom("invalid_content_type"))?,
            definition,
        )
        .await;

        Ok(())
    })?;

    Ok(builder)
}

impl_builder_nif!("response_builder_status", NifResponseBuilder, status(value: u16));
impl_builder_nif!("response_builder_ok", NifResponseBuilder, ok());
impl_builder_nif!("response_builder_created", NifResponseBuilder, created());
impl_builder_nif!(
    "response_builder_no_content",
    NifResponseBuilder,
    no_content()
);
impl_builder_nif!(
    "response_builder_forbidden",
    NifResponseBuilder,
    forbidden()
);
impl_builder_nif!(
    "response_builder_not_found",
    NifResponseBuilder,
    not_found()
);
impl_builder_nif!("response_builder_header", NifResponseBuilder, header(name: String, value: NifStringPattern));
impl_builder_nif!("response_builder_header_from_provider_state", NifResponseBuilder, header_from_provider_state(name: String, expression: String, value: NifStringPattern));
impl_builder_nif!("response_builder_content_type", NifResponseBuilder, content_type(value: String));
impl_builder_nif!("response_builder_html", NifResponseBuilder, html());
impl_builder_nif!(
    "response_builder_json_utf8",
    NifResponseBuilder,
    json_utf8()
);
impl_builder_nif!("response_builder_body", NifResponseBuilder, body(value: String));
impl_builder_nif!("response_builder_body2", NifResponseBuilder, body2(body: String, content_type: String));
impl_builder_nif!("response_builder_json_body", NifResponseBuilder, json_body(body: String));
impl_builder_nif!("response_builder_body_matching", NifResponseBuilder, body_matching(body: String));
impl_builder_nif!("response_builder_body_matching2", NifResponseBuilder, body_matching2(body: String, content_type: String));
