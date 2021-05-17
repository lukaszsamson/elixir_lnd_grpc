defmodule Lnclipb.VersionResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          lncli: Verrpc.Version.t() | nil,
          lnd: Verrpc.Version.t() | nil
        }

  defstruct [:lncli, :lnd]

  field :lncli, 1, type: Verrpc.Version
  field :lnd, 2, type: Verrpc.Version
end
