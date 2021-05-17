defmodule Watchtowerrpc.GetInfoRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3
  @type t :: %__MODULE__{}

  defstruct []
end

defmodule Watchtowerrpc.GetInfoResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          pubkey: binary,
          listeners: [String.t()],
          uris: [String.t()]
        }

  defstruct [:pubkey, :listeners, :uris]

  field :pubkey, 1, type: :bytes
  field :listeners, 2, repeated: true, type: :string
  field :uris, 3, repeated: true, type: :string
end

defmodule Watchtowerrpc.Watchtower.Service do
  @moduledoc false
  use GRPC.Service, name: "watchtowerrpc.Watchtower"

  rpc :GetInfo, Watchtowerrpc.GetInfoRequest, Watchtowerrpc.GetInfoResponse
end

defmodule Watchtowerrpc.Watchtower.Stub do
  @moduledoc false
  use GRPC.Stub, service: Watchtowerrpc.Watchtower.Service
end
