defmodule Pact.Native.Models.Interaction do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      defmodule Interaction do
        @moduledoc """
        Interaction
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
