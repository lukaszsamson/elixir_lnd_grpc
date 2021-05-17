defmodule Wtclientrpc.PolicyType do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3
  @type t :: integer | :LEGACY | :ANCHOR

  field :LEGACY, 0

  field :ANCHOR, 1
end

defmodule Wtclientrpc.AddTowerRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          pubkey: binary,
          address: String.t()
        }

  defstruct [:pubkey, :address]

  field :pubkey, 1, type: :bytes
  field :address, 2, type: :string
end

defmodule Wtclientrpc.AddTowerResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3
  @type t :: %__MODULE__{}

  defstruct []
end

defmodule Wtclientrpc.RemoveTowerRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          pubkey: binary,
          address: String.t()
        }

  defstruct [:pubkey, :address]

  field :pubkey, 1, type: :bytes
  field :address, 2, type: :string
end

defmodule Wtclientrpc.RemoveTowerResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3
  @type t :: %__MODULE__{}

  defstruct []
end

defmodule Wtclientrpc.GetTowerInfoRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          pubkey: binary,
          include_sessions: boolean
        }

  defstruct [:pubkey, :include_sessions]

  field :pubkey, 1, type: :bytes
  field :include_sessions, 2, type: :bool
end

defmodule Wtclientrpc.TowerSession do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          num_backups: non_neg_integer,
          num_pending_backups: non_neg_integer,
          max_backups: non_neg_integer,
          sweep_sat_per_byte: non_neg_integer
        }

  defstruct [:num_backups, :num_pending_backups, :max_backups, :sweep_sat_per_byte]

  field :num_backups, 1, type: :uint32
  field :num_pending_backups, 2, type: :uint32
  field :max_backups, 3, type: :uint32
  field :sweep_sat_per_byte, 4, type: :uint32
end

defmodule Wtclientrpc.Tower do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          pubkey: binary,
          addresses: [String.t()],
          active_session_candidate: boolean,
          num_sessions: non_neg_integer,
          sessions: [Wtclientrpc.TowerSession.t()]
        }

  defstruct [:pubkey, :addresses, :active_session_candidate, :num_sessions, :sessions]

  field :pubkey, 1, type: :bytes
  field :addresses, 2, repeated: true, type: :string
  field :active_session_candidate, 3, type: :bool
  field :num_sessions, 4, type: :uint32
  field :sessions, 5, repeated: true, type: Wtclientrpc.TowerSession
end

defmodule Wtclientrpc.ListTowersRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          include_sessions: boolean
        }

  defstruct [:include_sessions]

  field :include_sessions, 1, type: :bool
end

defmodule Wtclientrpc.ListTowersResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          towers: [Wtclientrpc.Tower.t()]
        }

  defstruct [:towers]

  field :towers, 1, repeated: true, type: Wtclientrpc.Tower
end

defmodule Wtclientrpc.StatsRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3
  @type t :: %__MODULE__{}

  defstruct []
end

defmodule Wtclientrpc.StatsResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          num_backups: non_neg_integer,
          num_pending_backups: non_neg_integer,
          num_failed_backups: non_neg_integer,
          num_sessions_acquired: non_neg_integer,
          num_sessions_exhausted: non_neg_integer
        }

  defstruct [
    :num_backups,
    :num_pending_backups,
    :num_failed_backups,
    :num_sessions_acquired,
    :num_sessions_exhausted
  ]

  field :num_backups, 1, type: :uint32
  field :num_pending_backups, 2, type: :uint32
  field :num_failed_backups, 3, type: :uint32
  field :num_sessions_acquired, 4, type: :uint32
  field :num_sessions_exhausted, 5, type: :uint32
end

defmodule Wtclientrpc.PolicyRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          policy_type: Wtclientrpc.PolicyType.t()
        }

  defstruct [:policy_type]

  field :policy_type, 1, type: Wtclientrpc.PolicyType, enum: true
end

defmodule Wtclientrpc.PolicyResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          max_updates: non_neg_integer,
          sweep_sat_per_byte: non_neg_integer
        }

  defstruct [:max_updates, :sweep_sat_per_byte]

  field :max_updates, 1, type: :uint32
  field :sweep_sat_per_byte, 2, type: :uint32
end

defmodule Wtclientrpc.WatchtowerClient.Service do
  @moduledoc false
  use GRPC.Service, name: "wtclientrpc.WatchtowerClient"

  rpc :AddTower, Wtclientrpc.AddTowerRequest, Wtclientrpc.AddTowerResponse

  rpc :RemoveTower, Wtclientrpc.RemoveTowerRequest, Wtclientrpc.RemoveTowerResponse

  rpc :ListTowers, Wtclientrpc.ListTowersRequest, Wtclientrpc.ListTowersResponse

  rpc :GetTowerInfo, Wtclientrpc.GetTowerInfoRequest, Wtclientrpc.Tower

  rpc :Stats, Wtclientrpc.StatsRequest, Wtclientrpc.StatsResponse

  rpc :Policy, Wtclientrpc.PolicyRequest, Wtclientrpc.PolicyResponse
end

defmodule Wtclientrpc.WatchtowerClient.Stub do
  @moduledoc false
  use GRPC.Stub, service: Wtclientrpc.WatchtowerClient.Service
end
