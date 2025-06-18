defmodule Pact.Native.Builders.RequestBuilder do
  @moduledoc false

  alias Pact.Native.PactConsumer.HttpRequest
  alias Pact.Native.PactConsumer.Request
  alias Pact.Patterns

  defmacro __using__(_opts) do
    quote do
      defmodule RequestBuilder do
        @moduledoc """
        Request Builder
        """
        @enforce_keys [:inner]
        defstruct [:inner]

        @type t :: %__MODULE__{
                inner: reference()
              }
      end

      @spec request_builder_default() :: RequestBuilder.t()
      def request_builder_default(), do: :erlang.nif_error(:nif_not_loaded)

      @spec request_builder_method(buider :: RequestBuilder.t(), method :: String.t()) ::
              RequestBuilder.t()
      def request_builder_method(_builder, _method), do: :erlang.nif_error(:nif_not_loaded)

      @spec request_builder_get(buider :: RequestBuilder.t()) :: RequestBuilder.t()
      def request_builder_get(_builder), do: :erlang.nif_error(:nif_not_loaded)

      @spec request_builder_post(buider :: RequestBuilder.t()) :: RequestBuilder.t()
      def request_builder_post(_builder), do: :erlang.nif_error(:nif_not_loaded)

      @spec request_builder_put(buider :: RequestBuilder.t()) :: RequestBuilder.t()
      def request_builder_put(_builder), do: :erlang.nif_error(:nif_not_loaded)

      @spec request_builder_delete(buider :: RequestBuilder.t()) :: RequestBuilder.t()
      def request_builder_delete(_builder), do: :erlang.nif_error(:nif_not_loaded)

      @spec request_builder_path(buider :: RequestBuilder.t(), path :: String.t()) ::
              RequestBuilder.t()
      def request_builder_path(_builder, _path), do: :erlang.nif_error(:nif_not_loaded)

      @spec request_builder_path_from_provider_state(
              buider :: RequestBuilder.t(),
              expression :: String.t(),
              path :: String.t()
            ) :: RequestBuilder.t()
      def request_builder_path_from_provider_state(_builder, _expression, _path),
        do: :erlang.nif_error(:nif_not_loaded)

      @spec request_builder_query_param(
              buider :: RequestBuilder.t(),
              key :: String.t(),
              value :: String.t()
            ) ::
              RequestBuilder.t()
      def request_builder_query_param(_builder, _key, _value),
        do: :erlang.nif_error(:nif_not_loaded)

      @spec request_builder_header(
              builder :: RequestBuilder.t(),
              name :: String.t(),
              value :: Patterns.string_pattern()
            ) :: RequestBuilder.t()
      def request_builder_header(_builder, _name, _value), do: :erlang.nif_error(:nif_not_loaded)

      @spec request_builder_header_from_provider_state(
              builder :: RequestBuilder.t(),
              name :: String.t(),
              expression :: String.t(),
              value :: Patterns.string_pattern()
            ) :: RequestBuilder.t()
      def request_builder_header_from_provider_state(_builder, _name, _expression, _value),
        do: :erlang.nif_error(:nif_not_loaded)

      @spec request_builder_content_type(builder :: RequestBuilder.t(), value :: String.t()) ::
              RequestBuilder.t()
      def request_builder_content_type(_builder, _value), do: :erlang.nif_error(:nif_not_loaded)

      @spec request_builder_html(builder :: RequestBuilder.t()) :: RequestBuilder.t()
      def request_builder_html(_builder), do: :erlang.nif_error(:nif_not_loaded)

      @spec request_builder_json_utf8(builder :: RequestBuilder.t()) :: RequestBuilder.t()
      def request_builder_json_utf8(_builder), do: :erlang.nif_error(:nif_not_loaded)

      @spec request_builder_body(builder :: RequestBuilder.t(), value :: String.t()) ::
              RequestBuilder.t()
      def request_builder_body(_builder, _value), do: :erlang.nif_error(:nif_not_loaded)

      @spec request_builder_body2(
              builder :: RequestBuilder.t(),
              body :: String.t(),
              content_type :: String.t()
            ) :: RequestBuilder.t()
      def request_builder_body2(_builder, _body, _content_type),
        do: :erlang.nif_error(:nif_not_loaded)

      @spec request_builder_json_body(
              builder :: RequestBuilder.t(),
              body :: Patterns.json_pattern()
            ) ::
              RequestBuilder.t()
      def request_builder_json_body(_builder, _body), do: :erlang.nif_error(:nif_not_loaded)

      @spec request_builder_body_matching(
              builder :: RequestBuilder.t(),
              body :: Patterns.string_pattern()
            ) ::
              RequestBuilder.t()
      def request_builder_body_matching(_builder, _body), do: :erlang.nif_error(:nif_not_loaded)

      @spec request_builder_body_matching2(
              builder :: RequestBuilder.t(),
              body :: Patterns.string_pattern(),
              content_type :: String.t()
            ) :: RequestBuilder.t()
      def request_builder_body_matching2(_builder, _body, _content_type),
        do: :erlang.nif_error(:nif_not_loaded)

      @spec request_builder_build(buider :: RequestBuilder.t()) :: Request.t()
      def request_builder_build(_builder), do: :erlang.nif_error(:nif_not_loaded)

      @spec request_builder_build_v4(buider :: RequestBuilder.t()) :: HttpRequest.t()
      def request_builder_build_v4(_builder), do: :erlang.nif_error(:nif_not_loaded)
    end
  end
end
