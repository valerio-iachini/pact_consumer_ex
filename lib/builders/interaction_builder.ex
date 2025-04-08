defmodule Pact.Builders.InteractionBuilder do
  @moduledoc """
  Builder for `Interaction` objects. Normally created via
  `Pact.Builder.PactBuilder.interaction`.
  """
  alias Pact.Native.PactConsumer, as: Native
  alias Pact.Builders.RequestBuilder
  alias Pact.Builders.ResponseBuilder

  @doc """
  Create a new interaction.
  """
  @spec new(description :: String.t(), interaction_type :: String.t()) ::
          Native.InteractionBuilder.t()
  def new(description, interaction_type),
    do: Native.interaction_builder_new(description, interaction_type)

  @doc """
  Specify a unique key for this interaction. This key will be used to determin
  equality of the interaction, so must be unique.
  """
  @spec with_key(builder :: Native.InteractionBuilder.t(), key :: String.t()) ::
          Native.InteractionBuilder.t()
  def with_key(builder, key), do: Native.interaction_builder_with_key(builder, key)

  @doc """
  Sets this interaction as pending. This will permantly mark the interaction as pending in the
  Pact file, and it will not cause a verification failure.
  """
  @spec pending(builder :: Native.InteractionBuilder.t(), pending :: bool()) ::
          Native.InteractionBuilder.t()
  def pending(builder, pending), do: Native.interaction_builder_pending(builder, pending)

  @doc """
  Specify a "provider state" for this interaction. This is normally use to
  set up database fixtures when using a pact to test a provider.
  """
  @spec given(builder :: Native.InteractionBuilder.t(), given :: String.t()) ::
          Native.InteractionBuilder.t()
  def given(builder, given), do: Native.interaction_builder_given(builder, given)

  @doc """
  Specify a "provider state" for this interaction with some defined parameters. This is normally use to set up database fixtures when using a pact to test a provider.
  """
  @spec given_with_params(
          builder :: Native.InteractionBuilder.t(),
          given :: String.t(),
          params :: term()
        ) ::
          Native.InteractionBuilder.t()
  def given_with_params(builder, given, params),
    do: Native.interaction_builder_given_with_params(builder, given, Jason.encode!(params))

  @doc """
  Adds a text comment to this interaction. This allows to specify just a bit more information about the interaction. It has no functional impact, but can be displayed in the broker HTML page, and potentially in the test output.
  """
  @spec comment(builder :: Native.InteractionBuilder.t(), comment :: String.t()) ::
          Native.InteractionBuilder.t()
  def comment(builder, comment), do: Native.interaction_builder_comment(builder, comment)

  @doc """
  Sets the test name for this interaction. This allows to specify just a bit more information about the interaction. It has no functional impact, but can be displayed in the broker HTML page, and potentially in the test output.
  """
  @spec test_name(builder :: Native.InteractionBuilder.t(), name :: String.t()) ::
          Native.InteractionBuilder.t()
  def test_name(builder, name), do: Native.interaction_builder_test_name(builder, name)

  @doc """
  Sets the protocol transport for this interaction. This would be required when there are different types of interactions in the Pact file (i.e. HTTP and messages).
  """
  @spec transport(builder :: Native.InteractionBuilder.t(), name :: String.t()) ::
          Native.InteractionBuilder.t()
  def transport(builder, name), do: Native.interaction_builder_transport(builder, name)

  @doc """
  Define the request for this interaction.
  """
  @spec request(
          builder :: Native.InteractionBuilder.t(),
          build_fn :: (request_builder :: Native.RequestBuilder.t() -> Native.RequestBuilder.t())
        ) :: Native.InteractionBuilder.t()
  def request(builder, build_fn),
    do: Native.interaction_builder_request(builder, build_fn.(RequestBuilder.default()))

  @doc """
  Define the response for this interaction.
  """
  @spec response(
          builder :: Native.InteractionBuilder.t(),
          build_fn :: (response_builder :: Native.RequestBuilder.t() -> Native.RequestBuilder.t())
        ) :: Native.InteractionBuilder.t()
  def response(builder, build_fn),
    do: Native.interaction_builder_response(builder, build_fn.(ResponseBuilder.default()))

  @doc """
  The interaction we've built.
  """
  @spec build(builder :: Native.InteractionBuilder.t()) :: Native.Interaction.t()
  def build(builder), do: Native.interaction_builder_build(builder)

  @doc """
  The interaction we've built (in V4 format).
  """
  @spec build_v4(builder :: Native.InteractionBuilder.t()) :: Native.Interaction.t()
  def build_v4(builder), do: Native.interaction_builder_build_v4(builder)
end
