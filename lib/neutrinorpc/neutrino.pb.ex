defmodule Neutrinorpc.StatusRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3
end

defmodule Neutrinorpc.StatusResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :active, 1, type: :bool
  field :synced, 2, type: :bool
  field :block_height, 3, type: :int32, json_name: "blockHeight"
  field :block_hash, 4, type: :string, json_name: "blockHash"
  field :peers, 5, repeated: true, type: :string
end

defmodule Neutrinorpc.AddPeerRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :peer_addrs, 1, type: :string, json_name: "peerAddrs"
end

defmodule Neutrinorpc.AddPeerResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3
end

defmodule Neutrinorpc.DisconnectPeerRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :peer_addrs, 1, type: :string, json_name: "peerAddrs"
end

defmodule Neutrinorpc.DisconnectPeerResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3
end

defmodule Neutrinorpc.IsBannedRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :peer_addrs, 1, type: :string, json_name: "peerAddrs"
end

defmodule Neutrinorpc.IsBannedResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :banned, 1, type: :bool
end

defmodule Neutrinorpc.GetBlockHeaderRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :hash, 1, type: :string
end

defmodule Neutrinorpc.GetBlockHeaderResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :hash, 1, type: :string
  field :confirmations, 2, type: :int64
  field :stripped_size, 3, type: :int64, json_name: "strippedSize"
  field :size, 4, type: :int64
  field :weight, 5, type: :int64
  field :height, 6, type: :int32
  field :version, 7, type: :int32
  field :version_hex, 8, type: :string, json_name: "versionHex"
  field :merkleroot, 9, type: :string
  field :time, 10, type: :int64
  field :nonce, 11, type: :uint32
  field :bits, 12, type: :string
  field :ntx, 13, type: :int32
  field :previous_block_hash, 14, type: :string, json_name: "previousBlockHash"
  field :raw_hex, 15, type: :bytes, json_name: "rawHex"
end

defmodule Neutrinorpc.GetBlockRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :hash, 1, type: :string
end

defmodule Neutrinorpc.GetBlockResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :hash, 1, type: :string
  field :confirmations, 2, type: :int64
  field :stripped_size, 3, type: :int64, json_name: "strippedSize"
  field :size, 4, type: :int64
  field :weight, 5, type: :int64
  field :height, 6, type: :int32
  field :version, 7, type: :int32
  field :version_hex, 8, type: :string, json_name: "versionHex"
  field :merkleroot, 9, type: :string
  field :tx, 10, repeated: true, type: :string
  field :time, 11, type: :int64
  field :nonce, 12, type: :uint32
  field :bits, 13, type: :string
  field :ntx, 14, type: :int32
  field :previous_block_hash, 15, type: :string, json_name: "previousBlockHash"
  field :raw_hex, 16, type: :bytes, json_name: "rawHex"
end

defmodule Neutrinorpc.GetCFilterRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :hash, 1, type: :string
end

defmodule Neutrinorpc.GetCFilterResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :filter, 1, type: :bytes
end

defmodule Neutrinorpc.NeutrinoKit.Service do
  @moduledoc false
  use GRPC.Service, name: "neutrinorpc.NeutrinoKit", protoc_gen_elixir_version: "0.11.0"

  rpc :Status, Neutrinorpc.StatusRequest, Neutrinorpc.StatusResponse

  rpc :AddPeer, Neutrinorpc.AddPeerRequest, Neutrinorpc.AddPeerResponse

  rpc :DisconnectPeer, Neutrinorpc.DisconnectPeerRequest, Neutrinorpc.DisconnectPeerResponse

  rpc :IsBanned, Neutrinorpc.IsBannedRequest, Neutrinorpc.IsBannedResponse

  rpc :GetBlockHeader, Neutrinorpc.GetBlockHeaderRequest, Neutrinorpc.GetBlockHeaderResponse

  rpc :GetBlock, Neutrinorpc.GetBlockRequest, Neutrinorpc.GetBlockResponse

  rpc :GetCFilter, Neutrinorpc.GetCFilterRequest, Neutrinorpc.GetCFilterResponse
end

defmodule Neutrinorpc.NeutrinoKit.Stub do
  @moduledoc false
  use GRPC.Stub, service: Neutrinorpc.NeutrinoKit.Service
end