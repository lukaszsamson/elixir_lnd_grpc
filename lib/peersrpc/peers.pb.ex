defmodule Peersrpc.UpdateAction do
  @moduledoc false
  use Protobuf, enum: true, protoc_gen_elixir_version: "0.10.0", syntax: :proto3

  field :ADD, 0
  field :REMOVE, 1
end
defmodule Peersrpc.FeatureSet do
  @moduledoc false
  use Protobuf, enum: true, protoc_gen_elixir_version: "0.10.0", syntax: :proto3

  field :SET_INIT, 0
  field :SET_LEGACY_GLOBAL, 1
  field :SET_NODE_ANN, 2
  field :SET_INVOICE, 3
  field :SET_INVOICE_AMP, 4
end
defmodule Peersrpc.UpdateAddressAction do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.0", syntax: :proto3

  field :action, 1, type: Peersrpc.UpdateAction, enum: true
  field :address, 2, type: :string
end
defmodule Peersrpc.UpdateFeatureAction do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.0", syntax: :proto3

  field :action, 1, type: Peersrpc.UpdateAction, enum: true
  field :feature_bit, 2, type: Lnrpc.FeatureBit, json_name: "featureBit", enum: true
end
defmodule Peersrpc.NodeAnnouncementUpdateRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.0", syntax: :proto3

  field :feature_updates, 1,
    repeated: true,
    type: Peersrpc.UpdateFeatureAction,
    json_name: "featureUpdates"

  field :color, 2, type: :string
  field :alias, 3, type: :string

  field :address_updates, 4,
    repeated: true,
    type: Peersrpc.UpdateAddressAction,
    json_name: "addressUpdates"
end
defmodule Peersrpc.NodeAnnouncementUpdateResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.0", syntax: :proto3

  field :ops, 1, repeated: true, type: Lnrpc.Op
end
defmodule Peersrpc.Peers.Service do
  @moduledoc false
  use GRPC.Service, name: "peersrpc.Peers", protoc_gen_elixir_version: "0.10.0"

  rpc :UpdateNodeAnnouncement,
      Peersrpc.NodeAnnouncementUpdateRequest,
      Peersrpc.NodeAnnouncementUpdateResponse
end

defmodule Peersrpc.Peers.Stub do
  @moduledoc false
  use GRPC.Stub, service: Peersrpc.Peers.Service
end
