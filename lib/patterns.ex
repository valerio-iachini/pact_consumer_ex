defmodule Pact.Patterns do
  @moduledoc """
  A module for creating JSON and string patterns for Pact testing.

  JSON patterns can include various data types and matchers, while string patterns
  are limited to strings and specific matchers.
  """

  @type json_pattern ::
          integer()
          | float()
          | boolean()
          | nil
          | binary()
          | atom()
          | list(json_pattern())
          | %{optional(atom() | binary()) => json_pattern()}
          | json_matcher()

  @type json_matcher ::
          {:datetime, String.t(), String.t()}
          | {:like, json_pattern()}
          | {:each_like, json_pattern(), non_neg_integer()}
          | {:matching_regex, String.t(), String.t()}

  @type string_pattern ::
          binary()
          | string_matcher()

  @type string_matcher ::
          {:datetime, String.t(), String.t()}
          | {:like, string_pattern()}
          | {:matching_regex, String.t(), String.t()}

  @doc """
  Creates a datetime matcher for both JSON and string patterns.

  ## Examples

      iex> Pact.Patterns.datetime("yyyy-MM-dd", "2000-01-01")
      {:datetime, "yyyy-MM-dd", "2000-01-01"}
  """
  @spec datetime(String.t(), String.t()) :: json_matcher() | string_matcher()
  def datetime(format, example), do: {:datetime, format, example}

  @doc """
  Creates a like matcher for JSON patterns. When used in string patterns, the inner
  pattern must be a valid string pattern.

  ## Examples

      iex> Pact.Patterns.like(42)
      {:like, 42}
  """
  @spec like(json_pattern()) :: json_matcher()
  def like(pattern), do: {:like, pattern}

  @doc """
  Creates an each_like matcher for JSON arrays with optional minimum length.

  ## Parameters
    - pattern: The example pattern for array elements
    - min_length: Minimum required array length (default: 1, must be ≥ 0)

  ## Examples
      # With default minimum length
      iex> Pact.Patterns.each_like("item")
      {:each_like, "item", 1}

      # With explicit minimum length
      iex> Pact.Patterns.each_like("item", 3)
      {:each_like, "item", 3}
  """
  @spec each_like(json_pattern()) :: json_matcher()
  @spec each_like(json_pattern(), non_neg_integer()) :: json_matcher()
  def each_like(pattern, min_length \\ 1)

  def each_like(pattern, min_length) when is_integer(min_length) and min_length >= 0,
    do: {:each_like, pattern, min_length}

  @doc """
  Creates a regex matcher (alias for matching_regex/2).

  ## Examples

      iex> Pact.Patterns.term("^\\d+$", "123")
      {:matching_regex, "^\\d+$", "123"}
  """
  @spec term(String.t(), String.t()) :: json_matcher() | string_matcher()
  def term(regex, example), do: {:matching_regex, regex, example}

  @doc """
  Creates a regex matcher for both JSON and string patterns.

  ## Examples

      iex> Pact.Patterns.matching_regex("^\\d+$", "123")
      {:matching_regex, "^\\d+$", "123"}
  """
  @spec matching_regex(String.t(), String.t()) :: json_matcher() | string_matcher()
  def matching_regex(regex, example), do: {:matching_regex, regex, example}

  @doc """
  Builds a JSON pattern structure.

  ## Examples

      iex> Pact.Patterns.json_pattern(%{"age" => Pact.Patterns.like(25)})
      %{"age" => {:like, 25}}
  """
  @spec json_pattern(json_pattern()) :: json_pattern()
  def json_pattern(pattern), do: pattern

  @doc """
  Builds a string pattern structure.

  ## Examples

      iex> Pact.Patterns.string_pattern(Pact.Patterns.like("example"))
      {:like, "example"}
  """
  @spec string_pattern(string_pattern()) :: string_pattern()
  def string_pattern(pattern), do: pattern
end
