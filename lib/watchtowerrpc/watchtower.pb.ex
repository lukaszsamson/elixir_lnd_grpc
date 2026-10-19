defmodule Watchtowerrpc.GetInfoRequest do
  @moduledoc false

  use Protobuf,
    full_name: "watchtowerrpc.GetInfoRequest",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3
end

defmodule Watchtowerrpc.GetInfoResponse do
  @moduledoc false

  use Protobuf,
    full_name: "watchtowerrpc.GetInfoResponse",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :pubkey, 1, type: :bytes
  field :listeners, 2, repeated: true, type: :string
  field :uris, 3, repeated: true, type: :string
end

defmodule Watchtowerrpc.Watchtower.Service do
  @moduledoc false

  use GRPC.Service, name: "watchtowerrpc.Watchtower", protoc_gen_elixir_version: "0.17.1"

  rpc :GetInfo, Watchtowerrpc.GetInfoRequest, Watchtowerrpc.GetInfoResponse
end

defmodule Watchtowerrpc.Watchtower.Stub do
  @moduledoc false

  use GRPC.Stub, service: Watchtowerrpc.Watchtower.Service
end
