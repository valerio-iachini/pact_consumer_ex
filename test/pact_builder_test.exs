defmodule Pact.Builders.PactBuilderTest do
  alias Pact.Builders.PactBuilder
  alias Pact.Builders.InteractionBuilder
  alias Pact.Builders.MessageBuilder
  alias Pact.Builders.RequestBuilder
  alias Pact.Builders.ResponseBuilder
  alias Pact.Models.V4.AsynchronousMessage
  alias Pact.MockServer
  import Pact.Patterns

  use ExUnit.Case

  doctest Pact.Patterns

  test "a_service_consumer_side_of_a_pact_goes_a_little_something_like_this" do
    {:ok, service} =
      PactBuilder.new("Consumer", "Alice Service")
      |> PactBuilder.interaction("A retrieve Mallory request", "", fn ib ->
        ib
        |> InteractionBuilder.given("there is some good mallory")
        |> InteractionBuilder.request(fn rb ->
          rb |> RequestBuilder.path("/mallory")
        end)
        |> InteractionBuilder.response(fn rb ->
          rb
          |> ResponseBuilder.content_type("text/plain")
          |> ResponseBuilder.body("That is some good Mallory.")
        end)
      end)
      |> PactBuilder.start_mock_server()

    response = HTTPoison.get!(MockServer.path(service, "/mallory"))

    assert %HTTPoison.Response{status_code: 200, body: "That is some good Mallory."} = response
  end

  test "message_client" do
    [message] =
      PactBuilder.new_v4("message-provider", "message-consumer")
      |> PactBuilder.message_interaction("hello message", fn mb ->
        mb
        |> MessageBuilder.test_name("test_message_client")
        |> MessageBuilder.json_body(json_pattern(%{"hello" => "world"}))
      end)
      |> PactBuilder.messages()

    assert AsynchronousMessage.bytes(message) == ~c"{\"hello\":\"world\"}"
  end
end
