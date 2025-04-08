use std::{
    ops::Deref,
    sync::{
        Mutex,
        mpsc::{Receiver, SyncSender, sync_channel},
    },
};

use pact_consumer::prelude::StartMockServer;
use rustler::{Env, NifResult, NifStruct, Resource, ResourceArc};

use crate::builders::pact_builder::NifPactBuilder;

pub struct CommandChannel(Mutex<SyncSender<Command>>);
pub struct ResponseChannel(Mutex<Receiver<String>>);

#[derive(NifStruct)]
#[module = "ValidatingMockServer"]
pub struct NifValidatingMockServer {
    inner: ResourceArc<ValidatingMockServerResource>,
}

impl Deref for NifValidatingMockServer {
    type Target = ValidatingMockServerResource;

    fn deref(&self) -> &Self::Target {
        &self.inner
    }
}

pub struct ValidatingMockServerResource {
    command_tx: CommandChannel,
    response_rx: ResponseChannel,
}

impl ValidatingMockServerResource {
    fn send_command(&self, command: Command) -> NifResult<()> {
        self.command_tx
            .0
            .lock()
            .map_err(|_e| rustler::error::Error::RaiseAtom("unable_lock_command_channel"))?
            .send(command)
            .map_err(|_e| rustler::error::Error::RaiseAtom("unable_send_command"))
    }

    fn receive_response(&self) -> NifResult<String> {
        self.response_rx
            .0
            .lock()
            .map_err(|_e| rustler::error::Error::RaiseAtom("unable_lock_response_channel"))?
            .recv()
            .map_err(|_e| rustler::error::Error::RaiseAtom("unable_receive_response"))
    }
}

impl Resource for ValidatingMockServerResource {
    fn destructor(self, _env: Env<'_>) {
        self.send_command(Command::Stop).expect("thread running");
    }
}

#[rustler::nif(name = "mock_server_url")]
pub fn url(mock_server: NifValidatingMockServer) -> NifResult<String> {
    mock_server.send_command(Command::Url)?;
    mock_server.receive_response()
}

#[rustler::nif(name = "mock_server_path")]
pub fn path(mock_server: NifValidatingMockServer, value: String) -> NifResult<String> {
    mock_server.send_command(Command::Path(value))?;
    mock_server.receive_response()
}

enum Command {
    Url,
    Path(String),
    Stop,
}

#[rustler::nif(name = "mock_server_start")]
pub fn start(builder: NifPactBuilder) -> NifResult<NifValidatingMockServer> {
    let (command_tx, command_rx) = sync_channel::<Command>(1);
    let (response_tx, response_rx) = sync_channel::<String>(1);

    std::thread::spawn(move || {
        let mock_server = builder
            .invoke(|b| Ok(b.start_mock_server(None, None)))
            .map_err(|_e| "Unable to start mock server".to_string())?;

        while let Ok(cmd) = command_rx.recv() {
            let response = match cmd {
                Command::Url => mock_server.url().to_string(),
                Command::Path(path) => mock_server.path(&path).to_string(),
                Command::Stop => break,
            };
            if let Err(e) = response_tx.send(response) {
                eprintln!("failed to send response: {}", e);
                break;
            }
        }
        Ok::<(), String>(())
    });

    Ok(NifValidatingMockServer {
        inner: ValidatingMockServerResource {
            command_tx: CommandChannel(Mutex::new(command_tx)),
            response_rx: ResponseChannel(Mutex::new(response_rx)),
        }
        .into(),
    })
}
