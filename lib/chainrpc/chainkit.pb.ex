defmodule Chainrpc.GetBlockRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :block_hash, 1, type: :bytes, json_name: "blockHash"
end

defmodule Chainrpc.GetBlockResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :raw_block, 1, type: :bytes, json_name: "rawBlock"
end

defmodule Chainrpc.GetBlockHeaderRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :block_hash, 1, type: :bytes, json_name: "blockHash"
end

defmodule Chainrpc.GetBlockHeaderResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :raw_block_header, 1, type: :bytes, json_name: "rawBlockHeader"
end

defmodule Chainrpc.GetBestBlockRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3
end

defmodule Chainrpc.GetBestBlockResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :block_hash, 1, type: :bytes, json_name: "blockHash"
  field :block_height, 2, type: :int32, json_name: "blockHeight"
end

defmodule Chainrpc.GetBlockHashRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :block_height, 1, type: :int64, json_name: "blockHeight"
end

defmodule Chainrpc.GetBlockHashResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :block_hash, 1, type: :bytes, json_name: "blockHash"
end

defmodule Chainrpc.ChainKit.Service do
  @moduledoc false
  use GRPC.Service, name: "chainrpc.ChainKit", protoc_gen_elixir_version: "0.11.0"

  rpc :GetBlock, Chainrpc.GetBlockRequest, Chainrpc.GetBlockResponse

  rpc :GetBlockHeader, Chainrpc.GetBlockHeaderRequest, Chainrpc.GetBlockHeaderResponse

  rpc :GetBestBlock, Chainrpc.GetBestBlockRequest, Chainrpc.GetBestBlockResponse

  rpc :GetBlockHash, Chainrpc.GetBlockHashRequest, Chainrpc.GetBlockHashResponse
end

defmodule Chainrpc.ChainKit.Stub do
  @moduledoc false
  use GRPC.Stub, service: Chainrpc.ChainKit.Service
end