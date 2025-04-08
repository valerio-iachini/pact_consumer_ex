defmodule Pact.Native.Models.V4.HttpParts do
  @moduledoc """
  Wraps native rust http parts.
  """
  defmacro __using__(_opts) do
    quote do
      defmodule HttpRequest do
        @moduledoc """
        Http Request
        """
        @enforce_keys [:inner]
        defstruct [:inner]

        @type t :: %__MODULE__{
                inner: reference()
              }
      end

      defmodule HttpResponse do
        @moduledoc """
        Http Response 
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
