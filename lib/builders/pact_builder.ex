defmodule Pact.Builders.PactBuilder do
  @moduledoc """
  Builder for `Pact` objects.
  """
  alias Pact.Native.PactConsumer, as: Native
  alias Pact.Builders.InteractionBuilder
  alias Pact.Builders.MessageBuilder
  alias Pact.MockServer

  @doc """
  Create a new `PactBuilder`, specifying the names of the service
  consuming the API and the service providing it.
  """
  @spec new(consumer :: String.t(), provider :: String.t()) :: Native.PactBuilder.t()
  def new(consumer, provider), do: Native.pact_builder_new(consumer, provider)

  @doc """
  Create a new `PactBuilder` for a V4 specification Pact, specifying the names of the service consuming the API and the service providing it.
  """
  @spec new_v4(consumer :: String.t(), provider :: String.t()) :: Native.PactBuilder.t()
  def new_v4(consumer, provider), do: Native.pact_builder_new_v4(consumer, provider)

  @doc """
  Add a new HTTP `Interaction` to the `Pact`. Needs to return a clone of the builder that is passed in.
  """
  @spec interaction(
          builder :: Native.PactBuilder.t(),
          description :: String.t(),
          interaction_type :: String.t(),
          build_fn ::
            (interaction_builder :: Native.InteractionBuilder.t() ->
               Native.InteractionBuilder.t())
        ) :: Native.PactBuilder.t()
  def interaction(builder, description, interaction_type, build_fn) do
    interaction = build_fn.(InteractionBuilder.new(description, interaction_type))

    if Native.pact_builder_is_v4(builder) do
      Native.pact_builder_push_interaction(
        builder,
        InteractionBuilder.build_v4(interaction)
      )
    else
      Native.pact_builder_push_interaction(
        builder,
        InteractionBuilder.build(interaction)
      )
    end
  end

  @doc """
  Add a new Asynchronous message `Interaction` to the `Pact`
  """
  @spec message_interaction(
          builder :: Native.PactBuilder.t(),
          description :: String.t(),
          build_fn ::
            (message_interaction_builder :: Native.MessageInteractionBuilder.t() ->
               Native.MessageInteractionBuilder.t())
        ) :: Native.PactBuilder.t()
  def message_interaction(builder, description, build_fn) do
    interaction = build_fn.(MessageBuilder.new(description))

    Native.pact_builder_push_interaction(
      builder,
      MessageBuilder.build(interaction)
    )
  end

  @doc """
  Checks whether the given pact builder is using the V4 specification.
  """
  @spec v4?(builder :: Native.PactBuilder.t()) :: bool()
  def v4?(builder), do: Native.pact_builder_is_v4(builder)

  @doc """
  Start a mock server running in a background thread. If the catalog entry is omitted, then a standard HTTP mock server will be started.
  """
  @spec start_mock_server(builder :: Native.PactBuilder.t()) ::
          :ignore | {:error, any()} | {:ok, pid()}
  def start_mock_server(builder), do: MockServer.start(builder)

  @doc """
  Returns an iterator over the asynchronous messages in the Pact
  """
  @spec messages(builder :: Native.PactBuilder.t()) :: [Native.AsynchronousMessage.t()]
  def messages(builder), do: Native.pact_builder_messages(builder)

  @doc """
  Add a plugin to be used by the test. This requires the plugins feature.

  Panics: Plugins only work with V4 specification pacts. This method will panic if the pact being built is V3 format. Use PactBuilder::new_v4 to create a builder with a V4 format pact.
  """
  @spec using_plugin(
          builder :: Native.PactBuilder.t(),
          name :: String.t(),
          version :: String.t() | nil
        ) :: Native.PactBuilder.t()
  def using_plugin(builder, name, version \\ nil),
    do: Native.pact_builder_using_plugin(builder, name, version)
end
