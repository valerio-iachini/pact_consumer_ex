use crate::{
    impl_builder_nif,
    models::{
        request::{NifRequest, RequestResource},
        v4::http_parts::{HttpRequestResource, NifHttpRequest},
    },
    patterns::{NifJsonPattern, NifStringPattern},
};
use pact_consumer::{builders::RequestBuilder, prelude::HttpPartBuilder};
use rustler::{NifResult, NifStruct, Resource, ResourceArc};
use std::{ops::Deref, sync::Mutex};

#[derive(NifStruct)]
#[module = "RequestBuilder"]
pub struct NifRequestBuilder {
    pub inner: ResourceArc<RequestBuilderResource>,
}

impl Deref for NifRequestBuilder {
    type Target = RequestBuilderResource;

    fn deref(&self) -> &Self::Target {
        &self.inner
    }
}

pub struct RequestBuilderResource(pub Mutex<RequestBuilder>);

#[allow(dead_code)]
impl NifRequestBuilder {
    fn invoke<F, T>(&self, fun: F) -> NifResult<T>
    where
        F: FnOnce(&mut RequestBuilder) -> NifResult<T>,
    {
        let mut inner = self
            .0
            .lock()
            .map_err(|_e| rustler::Error::RaiseAtom("invalid_request_builder_reference"))?;

        fun(&mut inner)
    }
}

impl Resource for RequestBuilderResource {}

#[rustler::nif(name = "request_builder_default")]
pub fn default() -> NifRequestBuilder {
    NifRequestBuilder {
        inner: ResourceArc::new(RequestBuilderResource(
            Mutex::new(RequestBuilder::default()),
        )),
    }
}

#[rustler::nif(name = "request_builder_build")]
pub fn build(builder: NifRequestBuilder) -> NifResult<NifRequest> {
    builder.invoke(|b| {
        Ok(NifRequest {
            inner: ResourceArc::new(RequestResource(b.build())),
        })
    })
}

#[rustler::nif(name = "request_builder_build_v4")]
pub fn build_v4(builder: NifRequestBuilder) -> NifResult<NifHttpRequest> {
    builder.invoke(|b| {
        Ok(NifHttpRequest {
            inner: ResourceArc::new(HttpRequestResource(b.build_v4())),
        })
    })
}

impl_builder_nif!("request_builder_method", NifRequestBuilder, method(value: String));
impl_builder_nif!("request_builder_get", NifRequestBuilder, get());
impl_builder_nif!("request_builder_post", NifRequestBuilder, post());
impl_builder_nif!("request_builder_put", NifRequestBuilder, put());
impl_builder_nif!("request_builder_delete", NifRequestBuilder, delete());
impl_builder_nif!("request_builder_path", NifRequestBuilder, path(value: String));
impl_builder_nif!("request_builder_path_from_provider_state", NifRequestBuilder, path_from_provider_state(expression: String, value: String));
impl_builder_nif!("request_builder_query_param", NifRequestBuilder, query_param(key: String, value: String));
impl_builder_nif!("request_builder_header", NifRequestBuilder, header(name: String, value: NifStringPattern));
impl_builder_nif!("request_builder_header_from_provider_state", NifRequestBuilder, header_from_provider_state(name: String, expression: String, value: NifStringPattern));
impl_builder_nif!("request_builder_content_type", NifRequestBuilder, content_type(value: String));
impl_builder_nif!("request_builder_html", NifRequestBuilder, html());
impl_builder_nif!("request_builder_json_utf8", NifRequestBuilder, json_utf8());
impl_builder_nif!("request_builder_body", NifRequestBuilder, body(value: String));
impl_builder_nif!("request_builder_body2", NifRequestBuilder, body2(body: String, content_type: String));
impl_builder_nif!("request_builder_json_body", NifRequestBuilder, json_body(body: NifJsonPattern));
impl_builder_nif!("request_builder_body_matching", NifRequestBuilder, body_matching(body: NifStringPattern));
impl_builder_nif!("request_builder_body_matching2", NifRequestBuilder, body_matching2(body: NifStringPattern, content_type: String));
