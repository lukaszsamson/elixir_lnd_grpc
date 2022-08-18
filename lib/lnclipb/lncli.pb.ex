defmodule Lnclipb.VersionResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.0", syntax: :proto3

  field :lncli, 1, type: Verrpc.Version
  field :lnd, 2, type: Verrpc.Version
end
