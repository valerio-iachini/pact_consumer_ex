defmodule Pact.Builders.RequestBuilder do
  @moduledoc """
  Builder for `Request` objects. Normally created via `Pact.Builders.PactBuilder`.
  """
  alias Pact.Native.PactConsumer, as: Native
  alias Pact.Patterns

  @doc """
  Creates and returns a new request builder with default settings.
  """
  @spec default() :: Native.RequestBuilder.t()
  def default(), do: Native.request_builder_default()

  @doc """
  Specify the request method. Defaults to `"GET"`.
  """
  @spec method(buider :: Native.RequestBuilder.t(), method :: String.t()) ::
          Native.RequestBuilder.t()
  def method(builder, method), do: Native.request_builder_method(builder, method)

  @doc """
  Set the HTTP method to `GET`. This is the default, so we don't actually care.
  """
  @spec get(buider :: Native.RequestBuilder.t()) :: Native.RequestBuilder.t()
  def get(builder), do: Native.request_builder_get(builder)

  @doc """
  Set the HTTP method to `POST`.
  """
  @spec post(buider :: Native.RequestBuilder.t()) :: Native.RequestBuilder.t()
  def post(builder), do: Native.request_builder_post(builder)

  @doc """
  Set the HTTP method to `PUT`.
  """
  @spec put(buider :: Native.RequestBuilder.t()) :: Native.RequestBuilder.t()
  def put(builder), do: Native.request_builder_put(builder)

  @doc """
  Set the HTTP method to `DELETE`.
  """
  @spec delete(buider :: Native.RequestBuilder.t()) :: Native.RequestBuilder.t()
  def delete(builder), do: Native.request_builder_delete(builder)

  @doc """
  Specify the request path. Defaults to `"/"`.
  """
  @spec path(buider :: Native.RequestBuilder.t(), path :: String.t()) :: Native.RequestBuilder.t()
  def path(builder, path), do: Native.request_builder_path(builder, path)

  @doc """
  Specify the request path with generators. Defaults to `"/"`.
  """
  @spec path_from_provider_state(
          buider :: Native.RequestBuilder.t(),
          expression :: String.t(),
          path :: String.t()
        ) :: Native.RequestBuilder.t()
  def path_from_provider_state(builder, expression, path),
    do: Native.request_builder_path_from_provider_state(builder, expression, path)

  @doc """
  Specify a query parameter. You may pass either a single value or a list of values to represent a repeated parameter.
  To pass multiple parameters with the same name, call `query_param` more than once with the same `key`.
  """
  @spec query_param(buider :: Native.RequestBuilder.t(), key :: String.t(), value :: String.t()) ::
          Native.RequestBuilder.t()
  def query_param(builder, key, value),
    do: Native.request_builder_query_param(builder, key, value)

  @doc """
  Specify a header pattern.
  """
  @spec header(
          builder :: Native.RequestBuilder.t(),
          name :: String.t(),
          value :: Patterns.string_pattern()
        ) ::
          Native.RequestBuilder.t()
  def header(builder, name, value), do: Native.request_builder_header(builder, name, value)

  @doc """
  Specify a header pattern and a generator from provider state.
  """
  @spec header_from_provider_state(
          builder :: Native.RequestBuilder.t(),
          name :: String.t(),
          expression :: String.t(),
          value :: Patterns.string_pattern()
        ) :: Native.RequestBuilder.t()
  def header_from_provider_state(builder, name, expression, value),
    do: Native.request_builder_header_from_provider_state(builder, name, expression, value)

  @doc """
  Set the `Content-Type` header.
  """
  @spec content_type(builder :: Native.RequestBuilder.t(), value :: String.t()) ::
          Native.RequestBuilder.t()
  def content_type(builder, value), do: Native.request_builder_content_type(builder, value)

  @doc """
  Set the `Content-Type` header to `text/html`.
  """
  @spec html(builder :: Native.RequestBuilder.t()) :: Native.RequestBuilder.t()
  def html(builder), do: Native.request_builder_html(builder)

  @doc """
  Set the `Content-Type` header to `application/json; charset=utf-8`,
  with enough flexibility to cover common variations.
  """
  @spec json_utf8(builder :: Native.RequestBuilder.t()) :: Native.RequestBuilder.t()
  def json_utf8(builder), do: Native.request_builder_json_utf8(builder)

  @doc """
  Specify a body literal. This does not allow using patterns.
  """
  @spec body(builder :: Native.RequestBuilder.t(), value :: String.t()) ::
          Native.RequestBuilder.t()
  def body(builder, value), do: Native.request_builder_body(builder, value)

  @doc """
  Specify a body literal with content type. This does not allow using patterns.
  """
  @spec body2(
          builder :: Native.RequestBuilder.t(),
          body :: String.t(),
          content_type :: String.t()
        ) ::
          Native.RequestBuilder.t()
  def body2(builder, body, content_type),
    do: Native.request_builder_body2(builder, body, content_type)

  @doc """
  Specify the body as `JsonPattern`, possibly including special matching rules.
  """
  @spec json_body(builder :: Native.RequestBuilder.t(), body :: Patterns.json_pattern()) ::
          Native.RequestBuilder.t()
  def json_body(builder, body), do: Native.request_builder_json_body(builder, Jason.encode!(body))

  @doc """
  Specify a text body (text/plain) matching the given pattern.
  """
  @spec body_matching(builder :: Native.RequestBuilder.t(), body :: Patterns.string_pattern()) ::
          Native.RequestBuilder.t()
  def body_matching(builder, body), do: Native.request_builder_body_matching(builder, body)

  @doc """
  Specify a text body matching the given pattern with a content type.
  """
  @spec body_matching2(
          builder :: Native.RequestBuilder.t(),
          body :: Patterns.string_pattern(),
          content_type :: String.t()
        ) ::
          Native.RequestBuilder.t()
  def body_matching2(builder, body, content_type),
    do: Native.request_builder_body_matching2(builder, body, content_type)

  @doc """
  Set the request body using the JSON data. If the body is being supplied by a plugin, this is what is sent to the plugin to setup the body.
  """
  @spec contents(
          builder :: Native.RequestBuilder.t(),
          content_type :: String.t(),
          definition :: term()
        ) :: Native.RequestBuilder.t()
  def contents(builder, content_type, definition),
    do: Native.request_builder_contents(builder, content_type, Jason.encode!(definition))

  @doc """
  Build the specified `Request` object.
  """
  @spec build(buider :: Native.RequestBuilder.t()) :: Native.Request.t()
  def build(builder), do: Native.request_builder_build(builder)

  @doc """
  Build the specified `Request` object in V4 format.
  """
  @spec build_v4(buider :: Native.RequestBuilder.t()) :: Native.HttpRequest.t()
  def build_v4(builder), do: Native.request_builder_build_v4(builder)
end
