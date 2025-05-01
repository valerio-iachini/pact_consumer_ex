defmodule Pact.Patterns.StringPattern do
  @moduledoc """
  A pattern which matches or generates a string.
  """
  @type matcher ::
          {:datetime, String.t(), String.t()}
          | {:like, t()}
          | {:each_like, t()}
          | {:matching_regex, String.t(), String.t()}

  @type t ::
          binary()
          | matcher()
  @doc"""
  A pattern which macthes the datetime format string `$format` and which generates `$example`.

  ## Examples

     iex> import Pact.Patterns.StringPattern
     iex> string_pattern(%{"created_date" => datetime("yyyy-MM-dd HH:mm:ss", "2001-01-02 25:33:45")})
     %{"created_date" => {:datetime, "yyyy-MM-dd HH:mm:ss", "2001-01-02 25:33:45"}}
  """
  @spec datetime(format :: String.t(), example :: String.t()) :: t()
  def datetime(format, example), do: {:datetime, format, example}

  @doc"""
  Generates the specified value, matches any value of the same data type. This
  is intended for use inside Pact.Patterns.StringPattern.string_pattern/1, and it interprets its arguments
  as a Pact.Patterns.StringPattern.string_pattern/1.

  ## Examples

       iex> import Pact.Patterns.StringPattern
       iex> string_pattern(like("hello"))
       {:like, "hello"}
  """
  @spec like(pattern :: t()) :: t()
  def like(pattern), do: {:like, pattern}

  @doc"""
  A pattern which matches the regular expression `$regex` (specified as a
  string) literal, and which generates `$example`.

  ## Examples

      iex> import Pact.Patterns.StringPattern
      iex> string_pattern(matching_regex("^[0-9a-z]+$", "10a"))
      {:matching_regex, "^[0-9a-z]+$", "10a"}
  """
  @spec term(regex :: String.t(), example :: String.t()) :: t()
  def term(regex, example), do: {:matching_regex, regex, example}

  @doc"""
  A pattern which matches the regular expression `$regex` (specified as a
  string) literal, and which generates `$example`.

  ## Examples

      iex> import Pact.Patterns.StringPattern
      iex> string_pattern(matching_regex("^[0-9a-z]+$", "10a"))
      {:matching_regex, "^[0-9a-z]+$", "10a"}
  """
  @spec matching_regex(regex :: String.t(), example :: String.t()) :: t()
  def matching_regex(regex, example), do: {:matching_regex, regex, example}

  @doc"""
  Method for building string patterns.

  ## Examples

       iex> import Pact.Patterns.StringPattern
       iex> string_pattern("Hello, world!")
       "Hello, world!"
  """
  @spec string_pattern(pattern :: t()) :: t()
  def string_pattern(pattern), do: pattern
end
