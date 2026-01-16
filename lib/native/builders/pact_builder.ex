defmodule Pact.Native.Builders.PactBuilder do
  @moduledoc false

  alias Pact.Native.PactConsumer.Interaction
  alias Pact.Native.PactConsumer.AsynchronousMessage

  defmacro __using__(_opts) do
    quote do
      defmodule PactBuilder do
        @moduledoc """
        Pact Builder
        """
        @enforce_keys [:inner, :is_v4]
        defstruct [:inner, :is_v4]

        @type t :: %__MODULE__{
                inner: reference(),
                is_v4: boolean()
              }
      end

      @spec pact_builder_new(consumer :: String.t(), provider :: String.t()) :: PactBuilder.t()
      def pact_builder_new(_consumer, _provider), do: :erlang.nif_error(:nif_not_loaded)

      @spec pact_builder_new_v4(consumer :: String.t(), provider :: String.t()) :: PactBuilder.t()
      def pact_builder_new_v4(_consumer, _provider), do: :erlang.nif_error(:nif_not_loaded)

      @spec pact_builder_push_interaction(
              builder :: PactBuilder.t(),
              interaction :: Interaction.t()
            ) :: PactBuilder.t()
      def pact_builder_push_interaction(_builder, _interaction),
        do: :erlang.nif_error(:nif_not_loaded)

      @spec pact_builder_is_v4(builder :: PactBuilder.t()) :: bool()
      def pact_builder_is_v4(_builder), do: :erlang.nif_error(:nif_not_loaded)

      @spec pact_builder_messages(builder :: PactBuilder.t()) :: [AsynchronousMessage.t()]
      def pact_builder_messages(_builder), do: :erlang.nif_error(:nif_not_loaded)

      @spec pact_builder_using_plugin(
              builder :: PactBuilder.t(),
              name :: String.t(),
              version :: String.t() | nil
            ) :: PactBuilder.t()
      def pact_builder_using_plugin(builder, name, version),
        do: :erlang.nif_error(:nif_not_loaded)
    end
  end
end
