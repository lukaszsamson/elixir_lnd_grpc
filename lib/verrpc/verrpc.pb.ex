defmodule Verrpc.VersionRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3
  @type t :: %__MODULE__{}

  defstruct []
end

defmodule Verrpc.Version do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          commit: String.t(),
          commit_hash: String.t(),
          version: String.t(),
          app_major: non_neg_integer,
          app_minor: non_neg_integer,
          app_patch: non_neg_integer,
          app_pre_release: String.t(),
          build_tags: [String.t()],
          go_version: String.t()
        }

  defstruct [
    :commit,
    :commit_hash,
    :version,
    :app_major,
    :app_minor,
    :app_patch,
    :app_pre_release,
    :build_tags,
    :go_version
  ]

  field :commit, 1, type: :string
  field :commit_hash, 2, type: :string
  field :version, 3, type: :string
  field :app_major, 4, type: :uint32
  field :app_minor, 5, type: :uint32
  field :app_patch, 6, type: :uint32
  field :app_pre_release, 7, type: :string
  field :build_tags, 8, repeated: true, type: :string
  field :go_version, 9, type: :string
end

defmodule Verrpc.Versioner.Service do
  @moduledoc false
  use GRPC.Service, name: "verrpc.Versioner"

  rpc :GetVersion, Verrpc.VersionRequest, Verrpc.Version
end

defmodule Verrpc.Versioner.Stub do
  @moduledoc false
  use GRPC.Stub, service: Verrpc.Versioner.Service
end
