defmodule Chainrpc.ConfRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :txid, 1, type: :bytes
  field :script, 2, type: :bytes
  field :num_confs, 3, type: :uint32, json_name: "numConfs"
  field :height_hint, 4, type: :uint32, json_name: "heightHint"
  field :include_block, 5, type: :bool, json_name: "includeBlock"
end

defmodule Chainrpc.ConfDetails do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :raw_tx, 1, type: :bytes, json_name: "rawTx"
  field :block_hash, 2, type: :bytes, json_name: "blockHash"
  field :block_height, 3, type: :uint32, json_name: "blockHeight"
  field :tx_index, 4, type: :uint32, json_name: "txIndex"
  field :raw_block, 5, type: :bytes, json_name: "rawBlock"
end

defmodule Chainrpc.Reorg do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3
end

defmodule Chainrpc.ConfEvent do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  oneof :event, 0

  field :conf, 1, type: Chainrpc.ConfDetails, oneof: 0
  field :reorg, 2, type: Chainrpc.Reorg, oneof: 0
end

defmodule Chainrpc.Outpoint do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :hash, 1, type: :bytes
  field :index, 2, type: :uint32
end

defmodule Chainrpc.SpendRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :outpoint, 1, type: Chainrpc.Outpoint
  field :script, 2, type: :bytes
  field :height_hint, 3, type: :uint32, json_name: "heightHint"
end

defmodule Chainrpc.SpendDetails do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :spending_outpoint, 1, type: Chainrpc.Outpoint, json_name: "spendingOutpoint"
  field :raw_spending_tx, 2, type: :bytes, json_name: "rawSpendingTx"
  field :spending_tx_hash, 3, type: :bytes, json_name: "spendingTxHash"
  field :spending_input_index, 4, type: :uint32, json_name: "spendingInputIndex"
  field :spending_height, 5, type: :uint32, json_name: "spendingHeight"
end

defmodule Chainrpc.SpendEvent do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  oneof :event, 0

  field :spend, 1, type: Chainrpc.SpendDetails, oneof: 0
  field :reorg, 2, type: Chainrpc.Reorg, oneof: 0
end

defmodule Chainrpc.BlockEpoch do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :hash, 1, type: :bytes
  field :height, 2, type: :uint32
end

defmodule Chainrpc.ChainNotifier.Service do
  @moduledoc false
  use GRPC.Service, name: "chainrpc.ChainNotifier", protoc_gen_elixir_version: "0.11.0"

  rpc :RegisterConfirmationsNtfn, Chainrpc.ConfRequest, stream(Chainrpc.ConfEvent)

  rpc :RegisterSpendNtfn, Chainrpc.SpendRequest, stream(Chainrpc.SpendEvent)

  rpc :RegisterBlockEpochNtfn, Chainrpc.BlockEpoch, stream(Chainrpc.BlockEpoch)
end

defmodule Chainrpc.ChainNotifier.Stub do
  @moduledoc false
  use GRPC.Stub, service: Chainrpc.ChainNotifier.Service
end