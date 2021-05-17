defmodule Autopilotrpc.StatusRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3
  @type t :: %__MODULE__{}

  defstruct []
end

defmodule Autopilotrpc.StatusResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          active: boolean
        }

  defstruct [:active]

  field :active, 1, type: :bool
end

defmodule Autopilotrpc.ModifyStatusRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          enable: boolean
        }

  defstruct [:enable]

  field :enable, 1, type: :bool
end

defmodule Autopilotrpc.ModifyStatusResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3
  @type t :: %__MODULE__{}

  defstruct []
end

defmodule Autopilotrpc.QueryScoresRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          pubkeys: [String.t()],
          ignore_local_state: boolean
        }

  defstruct [:pubkeys, :ignore_local_state]

  field :pubkeys, 1, repeated: true, type: :string
  field :ignore_local_state, 2, type: :bool
end

defmodule Autopilotrpc.QueryScoresResponse.HeuristicResult.ScoresEntry do
  @moduledoc false
  use Protobuf, map: true, syntax: :proto3

  @type t :: %__MODULE__{
          key: String.t(),
          value: float | :infinity | :negative_infinity | :nan
        }

  defstruct [:key, :value]

  field :key, 1, type: :string
  field :value, 2, type: :double
end

defmodule Autopilotrpc.QueryScoresResponse.HeuristicResult do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          heuristic: String.t(),
          scores: %{String.t() => float | :infinity | :negative_infinity | :nan}
        }

  defstruct [:heuristic, :scores]

  field :heuristic, 1, type: :string

  field :scores, 2,
    repeated: true,
    type: Autopilotrpc.QueryScoresResponse.HeuristicResult.ScoresEntry,
    map: true
end

defmodule Autopilotrpc.QueryScoresResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          results: [Autopilotrpc.QueryScoresResponse.HeuristicResult.t()]
        }

  defstruct [:results]

  field :results, 1, repeated: true, type: Autopilotrpc.QueryScoresResponse.HeuristicResult
end

defmodule Autopilotrpc.SetScoresRequest.ScoresEntry do
  @moduledoc false
  use Protobuf, map: true, syntax: :proto3

  @type t :: %__MODULE__{
          key: String.t(),
          value: float | :infinity | :negative_infinity | :nan
        }

  defstruct [:key, :value]

  field :key, 1, type: :string
  field :value, 2, type: :double
end

defmodule Autopilotrpc.SetScoresRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          heuristic: String.t(),
          scores: %{String.t() => float | :infinity | :negative_infinity | :nan}
        }

  defstruct [:heuristic, :scores]

  field :heuristic, 1, type: :string
  field :scores, 2, repeated: true, type: Autopilotrpc.SetScoresRequest.ScoresEntry, map: true
end

defmodule Autopilotrpc.SetScoresResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3
  @type t :: %__MODULE__{}

  defstruct []
end

defmodule Autopilotrpc.Autopilot.Service do
  @moduledoc false
  use GRPC.Service, name: "autopilotrpc.Autopilot"

  rpc :Status, Autopilotrpc.StatusRequest, Autopilotrpc.StatusResponse

  rpc :ModifyStatus, Autopilotrpc.ModifyStatusRequest, Autopilotrpc.ModifyStatusResponse

  rpc :QueryScores, Autopilotrpc.QueryScoresRequest, Autopilotrpc.QueryScoresResponse

  rpc :SetScores, Autopilotrpc.SetScoresRequest, Autopilotrpc.SetScoresResponse
end

defmodule Autopilotrpc.Autopilot.Stub do
  @moduledoc false
  use GRPC.Stub, service: Autopilotrpc.Autopilot.Service
end
