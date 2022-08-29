defmodule Autopilotrpc.StatusRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3
end

defmodule Autopilotrpc.StatusResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :active, 1, type: :bool
end

defmodule Autopilotrpc.ModifyStatusRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :enable, 1, type: :bool
end

defmodule Autopilotrpc.ModifyStatusResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3
end

defmodule Autopilotrpc.QueryScoresRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :pubkeys, 1, repeated: true, type: :string
  field :ignore_local_state, 2, type: :bool, json_name: "ignoreLocalState"
end

defmodule Autopilotrpc.QueryScoresResponse.HeuristicResult.ScoresEntry do
  @moduledoc false
  use Protobuf, map: true, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :key, 1, type: :string
  field :value, 2, type: :double
end

defmodule Autopilotrpc.QueryScoresResponse.HeuristicResult do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :heuristic, 1, type: :string

  field :scores, 2,
    repeated: true,
    type: Autopilotrpc.QueryScoresResponse.HeuristicResult.ScoresEntry,
    map: true
end

defmodule Autopilotrpc.QueryScoresResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :results, 1, repeated: true, type: Autopilotrpc.QueryScoresResponse.HeuristicResult
end

defmodule Autopilotrpc.SetScoresRequest.ScoresEntry do
  @moduledoc false
  use Protobuf, map: true, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :key, 1, type: :string
  field :value, 2, type: :double
end

defmodule Autopilotrpc.SetScoresRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3

  field :heuristic, 1, type: :string
  field :scores, 2, repeated: true, type: Autopilotrpc.SetScoresRequest.ScoresEntry, map: true
end

defmodule Autopilotrpc.SetScoresResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.11.0", syntax: :proto3
end

defmodule Autopilotrpc.Autopilot.Service do
  @moduledoc false
  use GRPC.Service, name: "autopilotrpc.Autopilot", protoc_gen_elixir_version: "0.11.0"

  rpc :Status, Autopilotrpc.StatusRequest, Autopilotrpc.StatusResponse

  rpc :ModifyStatus, Autopilotrpc.ModifyStatusRequest, Autopilotrpc.ModifyStatusResponse

  rpc :QueryScores, Autopilotrpc.QueryScoresRequest, Autopilotrpc.QueryScoresResponse

  rpc :SetScores, Autopilotrpc.SetScoresRequest, Autopilotrpc.SetScoresResponse
end

defmodule Autopilotrpc.Autopilot.Stub do
  @moduledoc false
  use GRPC.Stub, service: Autopilotrpc.Autopilot.Service
end