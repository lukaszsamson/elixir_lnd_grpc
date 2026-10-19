defmodule Devrpc.ImportGraphResponse do
  @moduledoc false

  use Protobuf,
    full_name: "devrpc.ImportGraphResponse",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3
end

defmodule Devrpc.Dev.Service do
  @moduledoc false

  use GRPC.Service, name: "devrpc.Dev", protoc_gen_elixir_version: "0.17.1"

  rpc :ImportGraph, Lnrpc.ChannelGraph, Devrpc.ImportGraphResponse
end

defmodule Devrpc.Dev.Stub do
  @moduledoc false

  use GRPC.Stub, service: Devrpc.Dev.Service
end
