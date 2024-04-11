defmodule Lnclipb.VersionResponse do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :lncli, 1, type: Verrpc.Version
  field :lnd, 2, type: Verrpc.Version
end