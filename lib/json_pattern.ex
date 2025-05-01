defmodule Pact.Patterns.JsonPattern do
  @moduledoc """
  A pattern which can be used to either:

  1. generate a sample JSON value, or
  2. test whether a JSON value matches the pattern.

  Many common types can be used as JSON patterns.
  """
  @type matcher ::
          {:datetime, String.t(), String.t()}
          | {:like, t()}
          | {:each_like, t()}
          | {:matching_regex, String.t(), String.t()}

  @type t ::
          integer()
          | float()
          | boolean()
          | nil
          | binary()
          | atom()
          | list(t())
          | %{key: t()}
          | matcher()
  @doc"""
  A pattern which macthes the datetime format string `$format` and which generates `$example`.

  ## Examples

     iex> import Pact.Patterns.JsonPattern
     iex> json_pattern(%{"created_date" => datetime("yyyy-MM-dd HH:mm:ss", "2001-01-02 25:33:45")})
     %{"created_date" => {:datetime, "yyyy-MM-dd HH:mm:ss", "2001-01-02 25:33:45"}}
  """
  @spec datetime(format :: String.t(), example :: String.t()) :: t()
  def datetime(format, example), do: {:datetime, format, example}

  @doc"""
  Generates the specified value, matches any value of the same data type. This
  is intended for use inside Pact.Patterns.JsonPattern.json_pattern/1, and it interprets its arguments
  as a Pact.Patterns.JsonPattern.json_pattern/1.

  ## Examples

       iex> import Pact.Patterns.JsonPattern
       iex> json_pattern(%{"id" => like(10), "metadata" => like(%{})})
       %{"id" => {:like, 10}, "metadata" => {:like, %{}}}
  """
  @spec like(pattern :: any()) :: t()
  def like(pattern), do: {:like, pattern}

  @doc"""
  Generates the specified value, matches any value of the same data type. This
  is intended for use inside Pact.Patterns.JsonPattern.json_pattern/1, and it interprets its arguments
  as a Pact.Patterns.JsonPattern.json_pattern/1.

  ## Examples

    iex> import Pact.Patterns.JsonPattern
    iex> json_pattern(%{"tags" => each_like("tag"), "people" => each_like(%{"name" => "J. Smith"})})
    %{"tags" => {:each_like, "tag"}, "people" => {:each_like, %{"name" => "J. Smith"}}}
  """
  @spec each_like(pattern :: any()) :: t()
  def each_like(pattern), do: {:each_like, pattern}

  @doc"""
  A pattern which matches the regular expression `$regex` (specified as a
  string) literal, and which generates `$example`. This is an alias for `matching_regex!`


  ## Examples

      iex> import Pact.Patterns.JsonPattern
      iex> json_pattern(%{"id_string" => term("^[0-9a-z]+$", "10a")})
      %{"id_string" => {:matching_regex, "^[0-9a-z]+$", "10a"}}
  """
  @spec term(regex :: String.t(), example :: String.t()) :: t()
  def term(regex, example), do: {:matching_regex, regex, example}

  @doc"""
  A pattern which matches the regular expression `$regex` (specified as a
  string) literal, and which generates `$example`.

  ## Examples

      iex> import Pact.Patterns.JsonPattern
      iex> json_pattern(%{"id_string" => matching_regex("^[0-9a-z]+$", "10a")})
      %{"id_string" => {:matching_regex, "^[0-9a-z]+$", "10a"}}
  """
  @spec matching_regex(regex :: String.t(), example :: String.t()) :: t()
  def matching_regex(regex, example), do: {:matching_regex, regex, example}

  @doc"""
  Method for building json patterns.

  ## Examples

       iex> import Pact.Patterns.JsonPattern
       iex> json_pattern(%{"message" => "Hello, world!", "location" => %{"x" => 1, "y" => 2}, "tags" => ["interesting"]})
       %{"message" => "Hello, world!", "location" => %{"x" => 1, "y" => 2}, "tags" => ["interesting"]}
  """
  @spec json_pattern(pattern :: t()) :: t()
  def json_pattern(pattern), do: pattern
end
