defmodule Pact.Native.PactConsumer do
  @moduledoc false
  version = Mix.Project.config()[:version]

  use RustlerPrecompiled,
    otp_app: :pact_consumer_ex,
    crate: "pact_consumer_nif",
    base_url: "https://github.com/valerio-iachini/pact_consumer_ex/releases/download/v#{version}",
    force_build: System.get_env("PACT_CONSUMER_EX_FORCE_BUILD") == "true",
    version: version,
    targets: [
      "aarch64-apple-darwin",
      "aarch64-unknown-linux-gnu",
      "aarch64-unknown-linux-musl",
      "arm-unknown-linux-gnueabihf",
      "riscv64gc-unknown-linux-gnu",
      "x86_64-apple-darwin",
      "x86_64-pc-windows-gnu",
      "x86_64-pc-windows-msvc",
      "x86_64-unknown-linux-gnu",
      "x86_64-unknown-linux-musl"
    ]

  use Pact.Native.Builders.InteractionBuilder
  use Pact.Native.Builders.MessageBuilder
  use Pact.Native.Builders.PactBuilder
  use Pact.Native.Builders.RequestBuilder
  use Pact.Native.Builders.ResponseBuilder
  use Pact.Native.MockServer
  use Pact.Native.Models.V4.AsyncMessage
  use Pact.Native.Models.V4.HttpParts
  use Pact.Native.Models.Interaction
  use Pact.Native.Models.Request
  use Pact.Native.Models.Response
end
