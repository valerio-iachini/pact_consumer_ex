defmodule Pact.Native.PactConsumer do
  @moduledoc false

  use Rustler, otp_app: :pact_consumer_ex, crate: "pact_consumer_nif"

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
