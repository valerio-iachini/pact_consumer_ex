use pact_models::v4::async_message::AsynchronousMessage;
use rustler::{NifResult, NifStruct, Resource, ResourceArc};

#[derive(NifStruct)]
#[module = "AsynchronousMessage"]
pub struct NifAsynchronousMessage {
    pub inner: ResourceArc<AsynchronousMessageResource>,
}

#[allow(dead_code)]
pub struct AsynchronousMessageResource(pub AsynchronousMessage);
impl Resource for AsynchronousMessageResource {}

#[rustler::nif(name = "models_v4_async_message_bytes")]
fn bytes(message: NifAsynchronousMessage) -> NifResult<Vec<u8>> {
    Ok(message
        .inner
        .0
        .contents
        .contents
        .value()
        .unwrap_or_default()
        .to_vec())
}
