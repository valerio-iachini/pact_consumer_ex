defmodule Pact.Native.Models.Request do
  @moduledoc """
  Wraps native rust interaction.
  """
  defmacro __using__(_opts) do
    quote do
      defmodule Request do
        @moduledoc """
        Request
        """
        @enforce_keys [:inner]
        defstruct [:inner]

        @type t :: %__MODULE__{
                inner: reference()
              }
      end
    end
  end
end
