defmodule Pact.Native.Builders.InteractionBuilder do
  @moduledoc false

  alias Pact.Native.PactConsumer.Interaction

  defmacro __using__(_opts) do
    quote do
      defmodule InteractionBuilder do
        @moduledoc """
        Interaction Builder
        """
        @enforce_keys [:inner]
        defstruct [:inner]

        @type t :: %__MODULE__{
                inner: reference()
              }
      end

      @spec interaction_builder_new(description :: String.t(), interaction_type :: String.t()) ::
              InteractionBuilder.t()
      def interaction_builder_new(_description, _interaction_type),
        do: :erlang.nif_error(:nif_not_loaded)

      @spec interaction_builder_with_key(buider :: InteractionBuilder.t(), key :: String.t()) ::
              InteractionBuilder.t()
      def interaction_builder_with_key(_builder, _key), do: :erlang.nif_error(:nif_not_loaded)

      @spec interaction_builder_pending(builder :: InteractionBuilder.t(), pending :: bool()) ::
              InteractionBuilder.t()
      def interaction_builder_pending(_builder, _pending), do: :erlang.nif_error(:nif_not_loaded)

      @spec interaction_builder_given(builder :: InteractionBuilder.t(), given :: String.t()) ::
              InteractionBuilder.t()
      def interaction_builder_given(_builder, _given), do: :erlang.nif_error(:nif_not_loaded)

      @spec interaction_builder_given_with_params(
              builder :: InteractionBuilder.t(),
              given :: String.t(),
              params :: String.t()
            ) :: InteractionBuilder.t()
      def interaction_builder_given_with_params(_builder, _given, _params),
        do: :erlang.nif_error(:nif_not_loaded)

      @spec interaction_builder_comment(builder :: InteractionBuilder.t(), comment :: String.t()) ::
              InteractionBuilder.t()
      def interaction_builder_comment(_builder, _comment), do: :erlang.nif_error(:nif_not_loaded)

      @spec interaction_builder_test_name(builder :: InteractionBuilder.t(), name :: String.t()) ::
              InteractionBuilder.t()
      def interaction_builder_test_name(_builder, _name), do: :erlang.nif_error(:nif_not_loaded)

      @spec interaction_builder_transport(builder :: InteractionBuilder.t(), name :: String.t()) ::
              InteractionBuilder.t()
      def interaction_builder_transport(_builder, _name), do: :erlang.nif_error(:nif_not_loaded)

      @spec interaction_builder_request(
              builder :: InteractionBuilder.t(),
              request_builder :: InteractionBuilder.t()
            ) ::
              InteractionBuilder.t()
      def interaction_builder_request(_builder, _request_builder),
        do: :erlang.nif_error(:nif_not_loaded)

      @spec interaction_builder_response(
              builder :: InteractionBuilder.t(),
              response_builder :: InteractionBuilder.t()
            ) ::
              InteractionBuilder.t()
      def interaction_builder_response(_builder, _response_builder),
        do: :erlang.nif_error(:nif_not_loaded)

      @spec interaction_builder_build(builder :: InteractionBuilder.t()) :: Interaction.t()
      def interaction_builder_build(_builder), do: :erlang.nif_error(:nif_not_loaded)

      @spec interaction_builder_build_v4(builder :: InteractionBuilder.t()) :: Interaction.t()
      def interaction_builder_build_v4(_builder), do: :erlang.nif_error(:nif_not_loaded)
    end
  end
end
