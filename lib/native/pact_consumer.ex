defmodule Pact.Native.PactConsumer do
  @moduledoc false
  @version "0.2.1"

  use RustlerPrecompiled,
    otp_app: :pact_consumer_ex,
    crate: "pact_consumer_nif",
    base_url:
      "https://github.com/valerio-iachini/pact_consumer_ex/releases/download/v#{@version}",
    force_build: System.get_env("PACT_CONSUMER_EX_FORCE_BUILD") == "true",
    version: @version

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
