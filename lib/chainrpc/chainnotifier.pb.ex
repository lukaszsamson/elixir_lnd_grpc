defmodule Chainrpc.ConfRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          txid: binary,
          script: binary,
          num_confs: non_neg_integer,
          height_hint: non_neg_integer
        }

  defstruct [:txid, :script, :num_confs, :height_hint]

  field :txid, 1, type: :bytes
  field :script, 2, type: :bytes
  field :num_confs, 3, type: :uint32
  field :height_hint, 4, type: :uint32
end

defmodule Chainrpc.ConfDetails do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          raw_tx: binary,
          block_hash: binary,
          block_height: non_neg_integer,
          tx_index: non_neg_integer
        }

  defstruct [:raw_tx, :block_hash, :block_height, :tx_index]

  field :raw_tx, 1, type: :bytes
  field :block_hash, 2, type: :bytes
  field :block_height, 3, type: :uint32
  field :tx_index, 4, type: :uint32
end

defmodule Chainrpc.Reorg do
  @moduledoc false
  use Protobuf, syntax: :proto3
  @type t :: %__MODULE__{}

  defstruct []
end

defmodule Chainrpc.ConfEvent do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          event: {atom, any}
        }

  defstruct [:event]

  oneof :event, 0
  field :conf, 1, type: Chainrpc.ConfDetails, oneof: 0
  field :reorg, 2, type: Chainrpc.Reorg, oneof: 0
end

defmodule Chainrpc.Outpoint do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          hash: binary,
          index: non_neg_integer
        }

  defstruct [:hash, :index]

  field :hash, 1, type: :bytes
  field :index, 2, type: :uint32
end

defmodule Chainrpc.SpendRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          outpoint: Chainrpc.Outpoint.t() | nil,
          script: binary,
          height_hint: non_neg_integer
        }

  defstruct [:outpoint, :script, :height_hint]

  field :outpoint, 1, type: Chainrpc.Outpoint
  field :script, 2, type: :bytes
  field :height_hint, 3, type: :uint32
end

defmodule Chainrpc.SpendDetails do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          spending_outpoint: Chainrpc.Outpoint.t() | nil,
          raw_spending_tx: binary,
          spending_tx_hash: binary,
          spending_input_index: non_neg_integer,
          spending_height: non_neg_integer
        }

  defstruct [
    :spending_outpoint,
    :raw_spending_tx,
    :spending_tx_hash,
    :spending_input_index,
    :spending_height
  ]

  field :spending_outpoint, 1, type: Chainrpc.Outpoint
  field :raw_spending_tx, 2, type: :bytes
  field :spending_tx_hash, 3, type: :bytes
  field :spending_input_index, 4, type: :uint32
  field :spending_height, 5, type: :uint32
end

defmodule Chainrpc.SpendEvent do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          event: {atom, any}
        }

  defstruct [:event]

  oneof :event, 0
  field :spend, 1, type: Chainrpc.SpendDetails, oneof: 0
  field :reorg, 2, type: Chainrpc.Reorg, oneof: 0
end

defmodule Chainrpc.BlockEpoch do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          hash: binary,
          height: non_neg_integer
        }

  defstruct [:hash, :height]

  field :hash, 1, type: :bytes
  field :height, 2, type: :uint32
end

defmodule Chainrpc.ChainNotifier.Service do
  @moduledoc false
  use GRPC.Service, name: "chainrpc.ChainNotifier"

  rpc :RegisterConfirmationsNtfn, Chainrpc.ConfRequest, stream(Chainrpc.ConfEvent)

  rpc :RegisterSpendNtfn, Chainrpc.SpendRequest, stream(Chainrpc.SpendEvent)

  rpc :RegisterBlockEpochNtfn, Chainrpc.BlockEpoch, stream(Chainrpc.BlockEpoch)
end

defmodule Chainrpc.ChainNotifier.Stub do
  @moduledoc false
  use GRPC.Stub, service: Chainrpc.ChainNotifier.Service
end
