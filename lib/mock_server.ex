defmodule Pact.MockServer do
  @moduledoc """
  A mock server that handles the requests described in a `Pact`, intended
  for use in tests, and validates that the requests made to that server are
  correct.

  Because this is intended for use in tests, it will panic if something goes
  wrong.
  """
  alias Pact.Native.PactConsumer, as: Native
  use GenServer

  defstruct mock_server: nil

  # client
  @spec start(pact_builder :: Native.PactBuilder.t()) :: :ignore | {:error, any()} | {:ok, pid()}
  def start(pact_builder) do
    GenServer.start_link(__MODULE__, pact_builder)
  end

  @doc """
  The base URL of the mock server. You can make normal HTTP requests using this
  as the base URL (if it is a HTTP-based mock server).
  """
  @spec url(pid :: pid()) :: String.t()
  def url(pid) do
    GenServer.call(pid, :url)
  end

  @doc"""
  Given a path string, return a URL pointing to that path on the mock
  server. If the path cannot be parsed as URL, **this function will
  panic**. For a non-panicking version, call Pact.MockServer.url/1 instead and build
  this path yourself.
  """
  @spec path(pid :: pid(), path :: String.t()) :: String.t()
  def path(pid, path) do
    GenServer.call(pid, {:path, path})
  end

  # Server (callbacks)

  @impl true
  def init(pact_builder) do
    mock_server = Native.mock_server_start(pact_builder)
    {:ok, %__MODULE__{mock_server: mock_server}}
  end

  @impl true
  def handle_call(:url, _from, state = %__MODULE__{mock_server: mock_server}),
    do: {:reply, Native.mock_server_url(mock_server), state}

  @impl true
  def handle_call({:path, path}, _from, state = %__MODULE__{mock_server: mock_server}),
    do: {:reply, Native.mock_server_path(mock_server, path), state}
end
