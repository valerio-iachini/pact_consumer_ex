use pact_models::prelude::Response;
use rustler::{NifStruct, Resource, ResourceArc};

#[derive(NifStruct)]
#[module = "Response"]
pub struct NifResponse {
    pub inner: ResourceArc<ResponseResource>,
}

#[allow(dead_code)]
pub struct ResponseResource(pub Response);
impl Resource for ResponseResource {}
