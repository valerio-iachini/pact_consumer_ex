defmodule Pact.Native.Builders.ResponseBuilder do
  @moduledoc false

  alias Pact.Native.PactConsumer.HttpResponse
  alias Pact.Native.PactConsumer.Response
  alias Pact.Patterns

  defmacro __using__(_opts) do
    quote do
      defmodule ResponseBuilder do
        @moduledoc """
        Response Builder
        """
        @enforce_keys [:inner]
        defstruct [:inner]

        @type t :: %__MODULE__{
                inner: reference()
              }
      end

      @spec response_builder_default() :: ResponseBuilder.t()
      def response_builder_default(), do: :erlang.nif_error(:nif_not_loaded)

      @spec response_builder_status(buider :: ResponseBuilder.t(), status :: pos_integer()) ::
              ResponseBuilder.t()
      def response_builder_status(_builder, _status), do: :erlang.nif_error(:nif_not_loaded)

      @spec response_builder_ok(buider :: ResponseBuilder.t()) :: ResponseBuilder.t()
      def response_builder_ok(_builder), do: :erlang.nif_error(:nif_not_loaded)

      @spec response_builder_created(buider :: ResponseBuilder.t()) :: ResponseBuilder.t()
      def response_builder_created(_builder), do: :erlang.nif_error(:nif_not_loaded)

      @spec response_builder_no_content(buider :: ResponseBuilder.t()) :: ResponseBuilder.t()
      def response_builder_no_content(_builder), do: :erlang.nif_error(:nif_not_loaded)

      @spec response_builder_unauthorized(buider :: ResponseBuilder.t()) :: ResponseBuilder.t()
      def response_builder_unauthorized(_builder), do: :erlang.nif_error(:nif_not_loaded)

      @spec response_builder_forbidden(buider :: ResponseBuilder.t()) :: ResponseBuilder.t()
      def response_builder_forbidden(_builder), do: :erlang.nif_error(:nif_not_loaded)

      @spec response_builder_not_found(buider :: ResponseBuilder.t()) :: ResponseBuilder.t()
      def response_builder_not_found(_builder), do: :erlang.nif_error(:nif_not_loaded)

      @spec response_builder_header(
              builder :: ResponseBuilder.t(),
              name :: String.t(),
              value :: Patterns.string_pattern()
            ) :: ResponseBuilder.t()
      def response_builder_header(_builder, _name, _value), do: :erlang.nif_error(:nif_not_loaded)

      @spec response_builder_header_from_provider_state(
              builder :: ResponseBuilder.t(),
              name :: String.t(),
              expression :: String.t(),
              value :: Patterns.string_pattern()
            ) :: ResponseBuilder.t()
      def response_builder_header_from_provider_state(_builder, _name, _expression, _value),
        do: :erlang.nif_error(:nif_not_loaded)

      @spec response_builder_content_type(builder :: ResponseBuilder.t(), value :: String.t()) ::
              ResponseBuilder.t()
      def response_builder_content_type(_builder, _value), do: :erlang.nif_error(:nif_not_loaded)

      @spec response_builder_html(builder :: ResponseBuilder.t()) :: ResponseBuilder.t()
      def response_builder_html(_builder), do: :erlang.nif_error(:nif_not_loaded)

      @spec response_builder_json_utf8(builder :: ResponseBuilder.t()) :: ResponseBuilder.t()
      def response_builder_json_utf8(_builder), do: :erlang.nif_error(:nif_not_loaded)

      @spec response_builder_body(builder :: ResponseBuilder.t(), value :: String.t()) ::
              ResponseBuilder.t()
      def response_builder_body(_builder, _value), do: :erlang.nif_error(:nif_not_loaded)

      @spec response_builder_body2(
              builder :: ResponseBuilder.t(),
              body :: String.t(),
              content_type :: String.t()
            ) :: ResponseBuilder.t()
      def response_builder_body2(_builder, _body, _content_type),
        do: :erlang.nif_error(:nif_not_loaded)

      @spec response_builder_json_body(
              builder :: ResponseBuilder.t(),
              body :: Patterns.json_pattern()
            ) ::
              ResponseBuilder.t()
      def response_builder_json_body(_builder, _body), do: :erlang.nif_error(:nif_not_loaded)

      @spec response_builder_body_matching(
              builder :: ResponseBuilder.t(),
              body :: Patterns.string_pattern()
            ) ::
              ResponseBuilder.t()
      def response_builder_body_matching(_builder, _body), do: :erlang.nif_error(:nif_not_loaded)

      @spec response_builder_body_matching2(
              builder :: ResponseBuilder.t(),
              body :: Patterns.string_pattern(),
              content_type :: String.t()
            ) :: ResponseBuilder.t()
      def response_builder_body_matching2(_builder, _body, _content_type),
        do: :erlang.nif_error(:nif_not_loaded)

      @spec response_builder_contents(
              builder :: ResponseBuilder.t(),
              content_type :: String.t(),
              definition :: String.t()
            ) :: ResponseBuilder.t()
      def response_builder_contents(_builder, _content_type, _definition),
        do: :erlang.nif_error(:nif_not_loaded)

      @spec response_builder_build(buider :: ResponseBuilder.t()) :: Response.t()
      def response_builder_build(_builder), do: :erlang.nif_error(:nif_not_loaded)

      @spec response_builder_build_v4(buider :: ResponseBuilder.t()) :: HttpResponse.t()
      def response_builder_build_v4(_builder), do: :erlang.nif_error(:nif_not_loaded)
    end
  end
end
