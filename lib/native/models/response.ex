defmodule Pact.Native.Models.Response do
  @moduledoc false

  defmacro __using__(_opts) do
    quote do
      defmodule Response do
        @moduledoc """
        Response
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
