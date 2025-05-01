defmodule Pact.Native.MockServer do
  @moduledoc false

  alias Pact.Native.PactConsumer.PactBuilder

  defmacro __using__(_opts) do
    quote do
      defmodule ValidatingMockServer do
        @moduledoc """
        Validating Mock Server
        """
        @enforce_keys [:inner]
        defstruct [:inner]

        @type t :: %__MODULE__{
                inner: reference()
              }
      end

      @spec mock_server_url(mock_server :: ValidatingMockServer.t()) :: String.t()
      def mock_server_url(_mock_server),
        do: :erlang.nif_error(:nif_not_loaded)

      @spec mock_server_path(mock_server :: ValidatingMockServer.t(), path :: String.t()) ::
              String.t()
      def mock_server_path(_mock_server, _path),
        do: :erlang.nif_error(:nif_not_loaded)

      @spec mock_server_start(pact_builder :: PactBuilder.t()) ::
              String.t()
      def mock_server_start(_pact_builder),
        do: :erlang.nif_error(:nif_not_loaded)
    end
  end
end
