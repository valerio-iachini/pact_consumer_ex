defmodule Pact.Builders.PactBuilderTest do
  alias Pact.Builders.InteractionBuilder
  alias Pact.Builders.MessageBuilder
  alias Pact.Builders.PactBuilder
  alias Pact.Builders.RequestBuilder
  alias Pact.Builders.ResponseBuilder
  alias Pact.MockServer
  alias Pact.Models.V4.AsynchronousMessage
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

  test "json matchers" do
    [message] =
      PactBuilder.new_v4("message-provider", "message-consumer")
      |> PactBuilder.message_interaction("hello message", fn mb ->
        mb
        |> MessageBuilder.test_name("test_message_client")
        |> MessageBuilder.json_body(
          json_pattern(%{
            "timestamp" =>
              datetime("yyyy-MM-dd'T'HH:mm:ss.nXXX", "2022-11-17T10:29:45.507366921Z"),
            "string" => like("Bob"),
            "list" => each_like(%{"name" => "Foo"}, 2),
            "regex_1" => term("^\d+$", "123"),
            "regex_2" => matching_regex("^\\d+$", "123")
          })
        )
      end)
      |> PactBuilder.messages()

    assert AsynchronousMessage.bytes(message) ==
             ~c"{\"list\":[{\"name\":\"Foo\"},{\"name\":\"Foo\"}],\"regex_1\":\"123\",\"regex_2\":\"123\",\"string\":\"Bob\",\"timestamp\":\"2022-11-17T10:29:45.507366921Z\"}"
  end

  test "string matchers" do
    [string_message, date_message, like_message, regex_message] =
      PactBuilder.new_v4("message-provider", "message-consumer")
      |> PactBuilder.message_interaction("string body", fn mb ->
        mb
        |> MessageBuilder.test_name("string pattern matcher")
        |> MessageBuilder.json_body(string_pattern("hello"))
      end)
      |> PactBuilder.message_interaction("date body", fn mb ->
        mb
        |> MessageBuilder.test_name("date matcher")
        |> MessageBuilder.json_body(
          string_pattern(datetime("yyyy-MM-dd'T'HH:mm:ss.nXXX", "2022-11-17T10:29:45.507366921Z"))
        )
      end)
      |> PactBuilder.message_interaction("like body", fn mb ->
        mb
        |> MessageBuilder.test_name("like matcher")
        |> MessageBuilder.json_body(string_pattern(like("hello")))
      end)
      |> PactBuilder.message_interaction("regex body", fn mb ->
        mb
        |> MessageBuilder.test_name("regex matcher")
        |> MessageBuilder.json_body(string_pattern(term(".*", "hello")))
      end)
      |> PactBuilder.messages()

    assert AsynchronousMessage.bytes(string_message) ==
             ~c"\"hello\""

    assert AsynchronousMessage.bytes(date_message) ==
             ~c"\"2022-11-17T10:29:45.507366921Z\""

    assert AsynchronousMessage.bytes(like_message) ==
             ~c"\"hello\""

    assert AsynchronousMessage.bytes(regex_message) ==
             ~c"\"hello\""
  end

  test "csv_plugin" do
    {:ok, service} =
      PactBuilder.new_v4("CsvClient", "CsvServer")
      |> PactBuilder.using_plugin("csv")
      |> PactBuilder.interaction("request for a CSV report", "", fn ib ->
        ib
        |> InteractionBuilder.request(fn rb ->
          rb |> RequestBuilder.path("/reports/report001.csv")
        end)
        |> InteractionBuilder.response(fn rb ->
          rb
          |> ResponseBuilder.ok()
          |> ResponseBuilder.contents(
            "text/csv",
            %{
              "csvHeaders" => false,
              "column:1" => "matching(type,'Name')",
              "column:2" => "matching(number,100)",
              "column:3" => "matching(datetime, 'yyyy-MM-dd','2000-01-01')"
            }
          )
        end)
      end)
      |> PactBuilder.start_mock_server()

    response = HTTPoison.get!(MockServer.path(service, "/reports/report001.csv"))

    assert %HTTPoison.Response{status_code: 200, body: "Name,100,2000-01-01\n"} = response
  end
end
