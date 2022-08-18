defmodule Neutrinorpc.StatusRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3
  @type t :: %__MODULE__{}

  defstruct []
end

defmodule Neutrinorpc.StatusResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          active: boolean,
          synced: boolean,
          block_height: integer,
          block_hash: String.t(),
          peers: [String.t()]
        }

  defstruct [:active, :synced, :block_height, :block_hash, :peers]

  field :active, 1, type: :bool
  field :synced, 2, type: :bool
  field :block_height, 3, type: :int32
  field :block_hash, 4, type: :string
  field :peers, 5, repeated: true, type: :string
end

defmodule Neutrinorpc.AddPeerRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          peer_addrs: String.t()
        }

  defstruct [:peer_addrs]

  field :peer_addrs, 1, type: :string
end

defmodule Neutrinorpc.AddPeerResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3
  @type t :: %__MODULE__{}

  defstruct []
end

defmodule Neutrinorpc.DisconnectPeerRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          peer_addrs: String.t()
        }

  defstruct [:peer_addrs]

  field :peer_addrs, 1, type: :string
end

defmodule Neutrinorpc.DisconnectPeerResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3
  @type t :: %__MODULE__{}

  defstruct []
end

defmodule Neutrinorpc.IsBannedRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          peer_addrs: String.t()
        }

  defstruct [:peer_addrs]

  field :peer_addrs, 1, type: :string
end

defmodule Neutrinorpc.IsBannedResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          banned: boolean
        }

  defstruct [:banned]

  field :banned, 1, type: :bool
end

defmodule Neutrinorpc.GetBlockHeaderRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          hash: String.t()
        }

  defstruct [:hash]

  field :hash, 1, type: :string
end

defmodule Neutrinorpc.GetBlockHeaderResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          hash: String.t(),
          confirmations: integer,
          stripped_size: integer,
          size: integer,
          weight: integer,
          height: integer,
          version: integer,
          version_hex: String.t(),
          merkleroot: String.t(),
          time: integer,
          nonce: non_neg_integer,
          bits: String.t(),
          ntx: integer,
          previous_block_hash: String.t(),
          raw_hex: binary
        }

  defstruct [
    :hash,
    :confirmations,
    :stripped_size,
    :size,
    :weight,
    :height,
    :version,
    :version_hex,
    :merkleroot,
    :time,
    :nonce,
    :bits,
    :ntx,
    :previous_block_hash,
    :raw_hex
  ]

  field :hash, 1, type: :string
  field :confirmations, 2, type: :int64
  field :stripped_size, 3, type: :int64
  field :size, 4, type: :int64
  field :weight, 5, type: :int64
  field :height, 6, type: :int32
  field :version, 7, type: :int32
  field :version_hex, 8, type: :string
  field :merkleroot, 9, type: :string
  field :time, 10, type: :int64
  field :nonce, 11, type: :uint32
  field :bits, 12, type: :string
  field :ntx, 13, type: :int32
  field :previous_block_hash, 14, type: :string
  field :raw_hex, 15, type: :bytes
end

defmodule Neutrinorpc.GetBlockRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          hash: String.t()
        }

  defstruct [:hash]

  field :hash, 1, type: :string
end

defmodule Neutrinorpc.GetBlockResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          hash: String.t(),
          confirmations: integer,
          stripped_size: integer,
          size: integer,
          weight: integer,
          height: integer,
          version: integer,
          version_hex: String.t(),
          merkleroot: String.t(),
          tx: [String.t()],
          time: integer,
          nonce: non_neg_integer,
          bits: String.t(),
          ntx: integer,
          previous_block_hash: String.t(),
          raw_hex: binary
        }

  defstruct [
    :hash,
    :confirmations,
    :stripped_size,
    :size,
    :weight,
    :height,
    :version,
    :version_hex,
    :merkleroot,
    :tx,
    :time,
    :nonce,
    :bits,
    :ntx,
    :previous_block_hash,
    :raw_hex
  ]

  field :hash, 1, type: :string
  field :confirmations, 2, type: :int64
  field :stripped_size, 3, type: :int64
  field :size, 4, type: :int64
  field :weight, 5, type: :int64
  field :height, 6, type: :int32
  field :version, 7, type: :int32
  field :version_hex, 8, type: :string
  field :merkleroot, 9, type: :string
  field :tx, 10, repeated: true, type: :string
  field :time, 11, type: :int64
  field :nonce, 12, type: :uint32
  field :bits, 13, type: :string
  field :ntx, 14, type: :int32
  field :previous_block_hash, 15, type: :string
  field :raw_hex, 16, type: :bytes
end

defmodule Neutrinorpc.GetCFilterRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          hash: String.t()
        }

  defstruct [:hash]

  field :hash, 1, type: :string
end

defmodule Neutrinorpc.GetCFilterResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          filter: binary
        }

  defstruct [:filter]

  field :filter, 1, type: :bytes
end

defmodule Neutrinorpc.NeutrinoKit.Service do
  @moduledoc false
  use GRPC.Service, name: "neutrinorpc.NeutrinoKit"

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
