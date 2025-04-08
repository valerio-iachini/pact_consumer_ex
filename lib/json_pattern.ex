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

  @spec datetime(format :: String.t(), example :: String.t()) :: t()
  def datetime(format, example), do: {:datetime, format, example}

  @spec like(pattern :: any()) :: t()
  def like(pattern), do: {:like, pattern}

  @spec each_like(pattern :: any()) :: t()
  def each_like(pattern), do: {:each_like, pattern}

  @spec term(regex :: String.t(), example :: String.t()) :: t()
  def term(regex, example), do: {:matching_regex, regex, example}

  @spec matching_regex(regex :: String.t(), example :: String.t()) :: t()
  def matching_regex(regex, example), do: {:matching_regex, regex, example}

  @spec json_pattern(pattern :: t()) :: t()
  def json_pattern(pattern), do: pattern
end
