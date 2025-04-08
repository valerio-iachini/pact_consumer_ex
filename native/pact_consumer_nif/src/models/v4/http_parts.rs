use pact_models::v4::http_parts::{HttpRequest, HttpResponse};
use rustler::{NifStruct, Resource, ResourceArc};

#[derive(NifStruct)]
#[module = "HttpRequest"]
pub struct NifHttpRequest {
    pub inner: ResourceArc<HttpRequestResource>,
}

#[allow(dead_code)]
pub struct HttpRequestResource(pub HttpRequest);

impl Resource for HttpRequestResource {}

#[derive(NifStruct)]
#[module = "HttpResponse"]
pub struct NifHttpResponse {
    pub inner: ResourceArc<HttpResponseResource>,
}

#[allow(dead_code)]
pub struct HttpResponseResource(pub HttpResponse);

impl Resource for HttpResponseResource {}
