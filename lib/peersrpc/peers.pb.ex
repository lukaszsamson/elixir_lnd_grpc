defmodule Peersrpc.UpdateAction do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3
  @type t :: integer | :ADD | :REMOVE

  field :ADD, 0

  field :REMOVE, 1
end

defmodule Peersrpc.FeatureSet do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

  @type t ::
          integer
          | :SET_INIT
          | :SET_LEGACY_GLOBAL
          | :SET_NODE_ANN
          | :SET_INVOICE
          | :SET_INVOICE_AMP

  field :SET_INIT, 0

  field :SET_LEGACY_GLOBAL, 1

  field :SET_NODE_ANN, 2

  field :SET_INVOICE, 3

  field :SET_INVOICE_AMP, 4
end

defmodule Peersrpc.UpdateAddressAction do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          action: Peersrpc.UpdateAction.t(),
          address: String.t()
        }

  defstruct [:action, :address]

  field :action, 1, type: Peersrpc.UpdateAction, enum: true
  field :address, 2, type: :string
end

defmodule Peersrpc.UpdateFeatureAction do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          action: Peersrpc.UpdateAction.t(),
          feature_bit: Lnrpc.FeatureBit.t()
        }

  defstruct [:action, :feature_bit]

  field :action, 1, type: Peersrpc.UpdateAction, enum: true
  field :feature_bit, 2, type: Lnrpc.FeatureBit, enum: true
end

defmodule Peersrpc.NodeAnnouncementUpdateRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          feature_updates: [Peersrpc.UpdateFeatureAction.t()],
          color: String.t(),
          alias: String.t(),
          address_updates: [Peersrpc.UpdateAddressAction.t()]
        }

  defstruct [:feature_updates, :color, :alias, :address_updates]

  field :feature_updates, 1, repeated: true, type: Peersrpc.UpdateFeatureAction
  field :color, 2, type: :string
  field :alias, 3, type: :string
  field :address_updates, 4, repeated: true, type: Peersrpc.UpdateAddressAction
end

defmodule Peersrpc.NodeAnnouncementUpdateResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          ops: [Lnrpc.Op.t()]
        }

  defstruct [:ops]

  field :ops, 1, repeated: true, type: Lnrpc.Op
end

defmodule Peersrpc.Peers.Service do
  @moduledoc false
  use GRPC.Service, name: "peersrpc.Peers"

  rpc :UpdateNodeAnnouncement,
      Peersrpc.NodeAnnouncementUpdateRequest,
      Peersrpc.NodeAnnouncementUpdateResponse
end

defmodule Peersrpc.Peers.Stub do
  @moduledoc false
  use GRPC.Stub, service: Peersrpc.Peers.Service
end
