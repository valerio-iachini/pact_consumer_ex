use std::panic::RefUnwindSafe;

use pact_models::prelude::Interaction;
use rustler::{NifStruct, Resource, ResourceArc};

#[derive(NifStruct)]
#[module = "Interaction"]
pub struct NifInteraction {
    pub inner: ResourceArc<InteractionResource>,
}

pub struct InteractionResource(pub Box<dyn Interaction + RefUnwindSafe + Sync + Send>);
impl Resource for InteractionResource {}
