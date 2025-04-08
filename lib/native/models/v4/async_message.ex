defmodule Pact.Native.Models.V4.AsyncMessage do
  @moduledoc """
  Wraps native rust functions for async messages.
  """
  defmacro __using__(_opts) do
    quote do
      defmodule AsynchronousMessage do
        @moduledoc """
        Asynchronous Message
        """
        @enforce_keys [:inner]
        defstruct [:inner]

        @type t :: %__MODULE__{
                inner: reference()
              }
      end

      @spec models_v4_async_message_bytes(async_message :: AsynchronousMessage.t()) ::
              binary()
      def models_v4_async_message_bytes(_async_message),
        do: :erlang.nif_error(:nif_not_loaded)
    end
  end
end
