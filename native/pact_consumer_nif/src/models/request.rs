use pact_models::request::Request;
use rustler::{NifStruct, Resource, ResourceArc};

#[derive(NifStruct)]
#[module = "Request"]
pub struct NifRequest {
    pub inner: ResourceArc<RequestResource>,
}

#[allow(dead_code)]
pub struct RequestResource(pub Request);

impl Resource for RequestResource {}
