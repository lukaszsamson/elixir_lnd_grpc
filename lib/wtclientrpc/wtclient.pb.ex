defmodule Wtclientrpc.PolicyType do
  @moduledoc false

  use Protobuf, enum: true, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :LEGACY, 0
  field :ANCHOR, 1
end

defmodule Wtclientrpc.AddTowerRequest do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :pubkey, 1, type: :bytes
  field :address, 2, type: :string
end

defmodule Wtclientrpc.AddTowerResponse do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"
end

defmodule Wtclientrpc.RemoveTowerRequest do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :pubkey, 1, type: :bytes
  field :address, 2, type: :string
end

defmodule Wtclientrpc.RemoveTowerResponse do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"
end

defmodule Wtclientrpc.GetTowerInfoRequest do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :pubkey, 1, type: :bytes
  field :include_sessions, 2, type: :bool, json_name: "includeSessions"
  field :exclude_exhausted_sessions, 3, type: :bool, json_name: "excludeExhaustedSessions"
end

defmodule Wtclientrpc.TowerSession do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :num_backups, 1, type: :uint32, json_name: "numBackups"
  field :num_pending_backups, 2, type: :uint32, json_name: "numPendingBackups"
  field :max_backups, 3, type: :uint32, json_name: "maxBackups"
  field :sweep_sat_per_byte, 4, type: :uint32, json_name: "sweepSatPerByte", deprecated: true
  field :sweep_sat_per_vbyte, 5, type: :uint32, json_name: "sweepSatPerVbyte"
end

defmodule Wtclientrpc.Tower do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :pubkey, 1, type: :bytes
  field :addresses, 2, repeated: true, type: :string

  field :active_session_candidate, 3,
    type: :bool,
    json_name: "activeSessionCandidate",
    deprecated: true

  field :num_sessions, 4, type: :uint32, json_name: "numSessions", deprecated: true
  field :sessions, 5, repeated: true, type: Wtclientrpc.TowerSession, deprecated: true

  field :session_info, 6,
    repeated: true,
    type: Wtclientrpc.TowerSessionInfo,
    json_name: "sessionInfo"
end

defmodule Wtclientrpc.TowerSessionInfo do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :active_session_candidate, 1, type: :bool, json_name: "activeSessionCandidate"
  field :num_sessions, 2, type: :uint32, json_name: "numSessions"
  field :sessions, 3, repeated: true, type: Wtclientrpc.TowerSession
  field :policy_type, 4, type: Wtclientrpc.PolicyType, json_name: "policyType", enum: true
end

defmodule Wtclientrpc.ListTowersRequest do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :include_sessions, 1, type: :bool, json_name: "includeSessions"
  field :exclude_exhausted_sessions, 2, type: :bool, json_name: "excludeExhaustedSessions"
end

defmodule Wtclientrpc.ListTowersResponse do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :towers, 1, repeated: true, type: Wtclientrpc.Tower
end

defmodule Wtclientrpc.StatsRequest do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"
end

defmodule Wtclientrpc.StatsResponse do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :num_backups, 1, type: :uint32, json_name: "numBackups"
  field :num_pending_backups, 2, type: :uint32, json_name: "numPendingBackups"
  field :num_failed_backups, 3, type: :uint32, json_name: "numFailedBackups"
  field :num_sessions_acquired, 4, type: :uint32, json_name: "numSessionsAcquired"
  field :num_sessions_exhausted, 5, type: :uint32, json_name: "numSessionsExhausted"
end

defmodule Wtclientrpc.PolicyRequest do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :policy_type, 1, type: Wtclientrpc.PolicyType, json_name: "policyType", enum: true
end

defmodule Wtclientrpc.PolicyResponse do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :max_updates, 1, type: :uint32, json_name: "maxUpdates"
  field :sweep_sat_per_byte, 2, type: :uint32, json_name: "sweepSatPerByte", deprecated: true
  field :sweep_sat_per_vbyte, 3, type: :uint32, json_name: "sweepSatPerVbyte"
end

defmodule Wtclientrpc.WatchtowerClient.Service do
  @moduledoc false

  use GRPC.Service, name: "wtclientrpc.WatchtowerClient", protoc_gen_elixir_version: "0.12.0"

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