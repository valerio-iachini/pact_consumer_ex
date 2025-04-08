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

  @spec datetime(format :: String.t(), example :: String.t()) :: t()
  def datetime(format, example), do: {:datetime, format, example}

  @spec like(pattern :: t()) :: t()
  def like(pattern), do: {:like, pattern}

  @spec each_like(pattern :: t()) :: t()
  def each_like(pattern), do: {:each_like, pattern}

  @spec term(regex :: String.t(), example :: String.t()) :: t()
  def term(regex, example), do: {:matching_regex, regex, example}

  @spec matching_regex(regex :: String.t(), example :: String.t()) :: t()
  def matching_regex(regex, example), do: {:matching_regex, regex, example}

  @spec string_pattern(pattern :: t()) :: t()
  def string_pattern(pattern), do: pattern
end
