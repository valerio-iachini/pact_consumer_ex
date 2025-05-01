defmodule Pact.Native.Builders.MessageBuilder do
  @moduledoc false

  alias Pact.Patterns
  alias Pact.Native.PactConsumer.Interaction

  defmacro __using__(_opts) do
    quote do
      defmodule MessageInteractionBuilder do
        @moduledoc """
        Message Interaction Builder
        """
        @enforce_keys [:inner]
        defstruct [:inner]

        @type t :: %__MODULE__{
                inner: reference()
              }
      end

      @spec message_builder_new(description :: String.t()) ::
              MessageInteractionBuilder.t()
      def message_builder_new(_description),
        do: :erlang.nif_error(:nif_not_loaded)

      @spec message_builder_with_key(buider :: MessageInteractionBuilder.t(), key :: String.t()) ::
              MessageInteractionBuilder.t()
      def message_builder_with_key(_builder, _key), do: :erlang.nif_error(:nif_not_loaded)

      @spec message_builder_pending(builder :: MessageInteractionBuilder.t(), pending :: bool()) ::
              MessageInteractionBuilder.t()
      def message_builder_pending(_builder, _pending), do: :erlang.nif_error(:nif_not_loaded)

      @spec message_builder_given(builder :: MessageInteractionBuilder.t(), given :: String.t()) ::
              MessageInteractionBuilder.t()
      def message_builder_given(_builder, _given), do: :erlang.nif_error(:nif_not_loaded)

      @spec message_builder_given_with_params(
              builder :: MessageInteractionBuilder.t(),
              given :: String.t(),
              params :: String.t()
            ) :: MessageInteractionBuilder.t()
      def message_builder_given_with_params(_builder, _given, _params),
        do: :erlang.nif_error(:nif_not_loaded)

      @spec message_builder_comment(
              builder :: MessageInteractionBuilder.t(),
              comment :: String.t()
            ) ::
              MessageInteractionBuilder.t()
      def message_builder_comment(_builder, _comment), do: :erlang.nif_error(:nif_not_loaded)

      @spec message_builder_test_name(
              builder :: MessageInteractionBuilder.t(),
              name :: String.t()
            ) ::
              MessageInteractionBuilder.t()
      def message_builder_test_name(_builder, _name), do: :erlang.nif_error(:nif_not_loaded)

      @spec message_builder_json_body(
              builder :: MessageInteractionBuilder.t(),
              body :: Patterns.json_pattern()
            ) ::
              MessageInteractionBuilder.t()
      def message_builder_json_body(_builder, _body), do: :erlang.nif_error(:nif_not_loaded)

      @spec message_builder_build(builder :: MessageInteractionBuilder.t()) :: Interaction.t()
      def message_builder_build(_builder), do: :erlang.nif_error(:nif_not_loaded)
    end
  end
end
