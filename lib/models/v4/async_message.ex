defmodule Pact.Models.V4.AsynchronousMessage do
  @moduledoc """
  Asynchronous interactions as a sequence of messages
  """
  alias Pact.Native.PactConsumer, as: Native

  @doc """
  Returns the raw content of the asynchronous message as a binary.
  """
  @spec bytes(asyc_message :: Native.AsynchronousMessage.t()) :: binary()
  def bytes(async_message), do: Native.models_v4_async_message_bytes(async_message)
end
