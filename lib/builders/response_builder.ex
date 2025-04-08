defmodule Pact.Builders.ResponseBuilder do
  @moduledoc """
  Builder for `Response` objects. Normally created via `Pact.Builders.PactBuilder`.
  """
  alias Pact.Native.PactConsumer, as: Native
  alias Pact.Patterns.JsonPattern
  alias Pact.Patterns.StringPattern

  @spec default() :: Native.ResponseBuilder.t()
  def default(), do: Native.response_builder_default()

  @doc """
  Set the status code for the response. Defaults to `200`.
  """
  @spec status(buider :: Native.ResponseBuilder.t(), status :: pos_integer()) ::
          Native.ResponseBuilder.t()
  def status(builder, status), do: Native.response_builder_status(builder, status)

  @doc """
  Set the status code to `200 OK`. (This is default.)
  """
  @spec ok(buider :: Native.ResponseBuilder.t()) :: Native.ResponseBuilder.t()
  def ok(builder), do: Native.response_builder_ok(builder)

  @doc """
  Set the status code to `201 Created`.
  """
  @spec created(buider :: Native.ResponseBuilder.t()) :: Native.ResponseBuilder.t()
  def created(builder), do: Native.response_builder_created(builder)

  @doc """
  Set the status code to `204 No Content`.
  """
  @spec no_content(buider :: Native.ResponseBuilder.t()) :: Native.ResponseBuilder.t()
  def no_content(builder), do: Native.response_builder_no_content(builder)

  @doc """
  Set the status code to `401 Unauthorized`.
  """
  @spec unauthorized(buider :: Native.ResponseBuilder.t()) :: Native.ResponseBuilder.t()
  def unauthorized(builder), do: Native.response_builder_unauthorized(builder)

  @doc """
  Set the status code to `403 Forbidden`.
  """
  @spec forbidden(buider :: Native.ResponseBuilder.t()) :: Native.ResponseBuilder.t()
  def forbidden(builder), do: Native.response_builder_forbidden(builder)

  @doc """
  Set the status code to `404 Not Found`.
  """
  @spec not_found(buider :: Native.ResponseBuilder.t()) :: Native.ResponseBuilder.t()
  def not_found(builder), do: Native.response_builder_not_found(builder)

  @doc """
  Specify a header pattern.
  """
  @spec header(
          builder :: Native.ResponseBuilder.t(),
          name :: String.t(),
          value :: StringPattern.t()
        ) :: Native.ResponseBuilder.t()
  def header(builder, name, value),
    do: Native.response_builder_header(builder, name, value)

  @doc """
  Specify a header pattern and a generator from provider state.
  """
  @spec header_from_provider_state(
          builder :: Native.ResponseBuilder.t(),
          name :: String.t(),
          expression :: String.t(),
          value :: StringPattern.t()
        ) :: Native.ResponseBuilder.t()
  def header_from_provider_state(builder, name, expression, value),
    do: Native.response_builder_header_from_provider_state(builder, name, expression, value)

  @doc """
  Set the `Content-Type` header.
  """
  @spec content_type(builder :: Native.ResponseBuilder.t(), value :: String.t()) ::
          Native.ResponseBuilder.t()
  def content_type(builder, value),
    do: Native.response_builder_content_type(builder, value)

  @doc """
  Set the `Content-Type` header to `text/html`.
  """
  @spec html(builder :: Native.ResponseBuilder.t()) :: Native.ResponseBuilder.t()
  def html(builder),
    do: Native.response_builder_html(builder)

  @doc """
  Set the `Content-Type` header to `application/json; charset=utf-8`,
  with enough flexibility to cover common variations.
  """
  @spec json_utf8(builder :: Native.ResponseBuilder.t()) :: Native.ResponseBuilder.t()
  def json_utf8(builder),
    do: Native.response_builder_json_utf8(builder)

  @doc """
  Specify a body literal. This does not allow using patterns.
  """
  @spec body(builder :: Native.ResponseBuilder.t(), value :: String.t()) ::
          Native.ResponseBuilder.t()
  def body(builder, value),
    do: Native.response_builder_body(builder, value)

  @doc """
  Specify a body literal with content type. This does not allow using patterns.
  """
  @spec body2(
          builder :: Native.ResponseBuilder.t(),
          body :: String.t(),
          content_type :: String.t()
        ) :: Native.ResponseBuilder.t()
  def body2(builder, body, content_type),
    do: Native.response_builder_body2(builder, body, content_type)

  @doc """
  Specify a body literal. This does not allow using patterns.
  """
  @spec json_body(builder :: Native.ResponseBuilder.t(), body :: JsonPattern.t()) ::
          Native.ResponseBuilder.t()
  def json_body(builder, body),
    do: Native.response_builder_json_body(builder, Jason.encode!(body))

  @doc """
  Specify a text body (text/plain) matching the given pattern.
  """
  @spec body_matching(builder :: Native.ResponseBuilder.t(), body :: StringPattern.t()) ::
          Native.ResponseBuilder.t()
  def body_matching(builder, body),
    do: Native.response_builder_body_matching(builder, body)

  @doc """
  Specify a text body matching the given pattern with a content type.
  """
  @spec body_matching2(
          builder :: Native.ResponseBuilder.t(),
          body :: StringPattern.t(),
          content_type :: String.t()
        ) :: Native.ResponseBuilder.t()
  def body_matching2(builder, body, content_type),
    do: Native.response_builder_body_matching2(builder, body, content_type)

  @doc """
  Build the specified `Response` object.
  """
  @spec build(buider :: Native.ResponseBuilder.t()) :: Native.Response.t()
  def build(builder), do: Native.response_builder_build(builder)

  @doc """
  Build the specified `Response` object in V4 format.
  """
  @spec build_v4(buider :: Native.ResponseBuilder.t()) :: Native.HttpResponse.t()
  def build_v4(builder), do: Native.response_builder_build_v4(builder)
end
