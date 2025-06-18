defmodule Pact.Builders.MessageBuilder do
  @moduledoc """
  Asynchronous message interaction builder. Normally created via `Pact.Builders.PactBuilder.message_interaction`.
  """
  alias Pact.Native.PactConsumer, as: Native
  alias Pact.Patterns

  @doc """
  Create a new message interaction builder, Description is the interaction description and interaction_type is the type of message (leave empty for the default type).
  """
  @spec new(description :: String.t()) :: Native.MessageInteractionBuilder.t()
  def new(description),
    do: Native.message_builder_new(description)

  @doc """
   Specify a unique key for this interaction. This key will be used to determine equality of the interaction, so must be unique.
  """
  @spec with_key(buider :: Native.MessageInteractionBuilder.t(), key :: String.t()) ::
          Native.MessageInteractionBuilder.t()
  def with_key(builder, key), do: Native.message_builder_with_key(builder, key)

  @doc """
  Sets this interaction as pending. This will permantly mark the interaction as pending in the Pact file, and it will not cause a verification failure.
  """
  @spec pending(builder :: Native.MessageInteractionBuilder.t(), pending :: bool()) ::
          Native.MessageInteractionBuilder.t()
  def pending(builder, pending), do: Native.message_builder_pending(builder, pending)

  @doc """
  Specify a "provider state" for this interaction. This is normally use to set up database fixtures when using a pact to test a provider.
  """
  @spec given(builder :: Native.MessageInteractionBuilder.t(), given :: String.t()) ::
          Native.MessageInteractionBuilder.t()
  def given(builder, given), do: Native.message_builder_given(builder, given)

  @doc """
  Specify a "provider state" for this interaction with some defined parameters. This is normally use to set up database fixtures when using a pact to test a provider.
  """
  @spec given_with_params(
          builder :: Native.MessageInteractionBuilder.t(),
          given :: String.t(),
          params :: term()
        ) ::
          Native.MessageInteractionBuilder.t()
  def given_with_params(builder, given, params),
    do: Native.message_builder_given_with_params(builder, given, Jason.encode!(params))

  @doc """
  Adds a text comment to this interaction. This allows to specify just a bit more information about the interaction. It has no functional impact, but can be displayed in the broker HTML page, and potentially in the test output.
  """
  @spec comment(builder :: Native.MessageInteractionBuilder.t(), comment :: String.t()) ::
          Native.MessageInteractionBuilder.t()
  def comment(builder, comment), do: Native.message_builder_comment(builder, comment)

  @doc """
  Sets the test name for this interaction. This allows to specify just a bit more information about the interaction. It has no functional impact, but can be displayed in the broker HTML page, and potentially in the test output.
  """
  @spec test_name(builder :: Native.MessageInteractionBuilder.t(), name :: String.t()) ::
          Native.MessageInteractionBuilder.t()
  def test_name(builder, name), do: Native.message_builder_test_name(builder, name)

  @doc """
  Specify the body as `JsonPattern`, possibly including special matching
  rules.
  """
  @spec json_body(
          builder :: Native.MessageInteractionBuilder.t(),
          body :: Patterns.json_pattern()
        ) ::
          Native.MessageInteractionBuilder.t()
  def json_body(builder, body), do: Native.message_builder_json_body(builder, body)

  @doc """
  The interaction we've built
  """
  @spec build(builder :: Native.MessageInteractionBuilder.t()) :: Native.Interaction.t()
  def build(builder), do: Native.message_builder_build(builder)
end
