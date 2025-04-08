mod builders;
mod mock_server;
mod models;
mod patterns;

use builders::{
    interaction_builder::InteractionBuilderResource,
    message_builder::MessageInteractionBuilderResource, pact_builder::PactBuilderResource,
    request_builder::RequestBuilderResource, response_builder::ResponseBuilderResource,
};
use mock_server::ValidatingMockServerResource;
use models::{
    interaction::InteractionResource,
    request::RequestResource,
    response::ResponseResource,
    v4::{
        async_message::AsynchronousMessageResource,
        http_parts::{HttpRequestResource, HttpResponseResource},
    },
};
use rustler::{Env, Term};
use std::env;

fn on_load(env: Env, _: Term) -> bool {
    unsafe {
        env::set_var("RUST_BACKTRACE", "1");
    }
    env_logger::init();

    std::panic::set_hook(Box::new(|panic_info| {
        let backtrace = std::backtrace::Backtrace::force_capture();

        if let Some(s) = panic_info.payload().downcast_ref::<&str>() {
            log::error!("panic occurred: {:?}", s);
        } else if let Some(s) = panic_info.payload().downcast_ref::<String>() {
            log::error!("panic occurred: {:?}", s);
        } else {
            log::error!("panic occurred but payload is not a string");
        }

        if let Some(location) = panic_info.location() {
            log::error!(
                "panic occurred in file '{}' at line {}",
                location.file(),
                location.line()
            );
        } else {
            log::error!("panic location unknown.");
        }

        log::error!("backtrace:\n{:?}", backtrace);
    }));

    env.register::<PactBuilderResource>().is_ok()
        && env.register::<InteractionBuilderResource>().is_ok()
        && env.register::<InteractionResource>().is_ok()
        && env.register::<RequestBuilderResource>().is_ok()
        && env.register::<RequestResource>().is_ok()
        && env.register::<HttpRequestResource>().is_ok()
        && env.register::<ResponseBuilderResource>().is_ok()
        && env.register::<ResponseResource>().is_ok()
        && env.register::<HttpResponseResource>().is_ok()
        && env.register::<ValidatingMockServerResource>().is_ok()
        && env.register::<MessageInteractionBuilderResource>().is_ok()
        && env.register::<AsynchronousMessageResource>().is_ok()
}

rustler::init! {"Elixir.Pact.Native.PactConsumer", load = on_load}
