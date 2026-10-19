defmodule Lnclipb.VersionResponse do
  @moduledoc false

  use Protobuf,
    full_name: "lnclipb.VersionResponse",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :lncli, 1, type: Verrpc.Version
  field :lnd, 2, type: Verrpc.Version
end
