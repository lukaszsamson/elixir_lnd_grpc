defmodule Lnrpc.WalletState do
  @moduledoc false

  use Protobuf, enum: true, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :NON_EXISTING, 0
  field :LOCKED, 1
  field :UNLOCKED, 2
  field :RPC_ACTIVE, 3
  field :SERVER_ACTIVE, 4
  field :WAITING_TO_START, 255
end

defmodule Lnrpc.SubscribeStateRequest do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"
end

defmodule Lnrpc.SubscribeStateResponse do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :state, 1, type: Lnrpc.WalletState, enum: true
end

defmodule Lnrpc.GetStateRequest do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"
end

defmodule Lnrpc.GetStateResponse do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :state, 1, type: Lnrpc.WalletState, enum: true
end

defmodule Lnrpc.State.Service do
  @moduledoc false

  use GRPC.Service, name: "lnrpc.State", protoc_gen_elixir_version: "0.12.0"

  rpc :SubscribeState, Lnrpc.SubscribeStateRequest, stream(Lnrpc.SubscribeStateResponse)

  rpc :GetState, Lnrpc.GetStateRequest, Lnrpc.GetStateResponse
end

defmodule Lnrpc.State.Stub do
  @moduledoc false

  use GRPC.Stub, service: Lnrpc.State.Service
end