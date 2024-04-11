defmodule Verrpc.VersionRequest do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"
end

defmodule Verrpc.Version do
  @moduledoc false

  use Protobuf, syntax: :proto3, protoc_gen_elixir_version: "0.12.0"

  field :commit, 1, type: :string
  field :commit_hash, 2, type: :string, json_name: "commitHash"
  field :version, 3, type: :string
  field :app_major, 4, type: :uint32, json_name: "appMajor"
  field :app_minor, 5, type: :uint32, json_name: "appMinor"
  field :app_patch, 6, type: :uint32, json_name: "appPatch"
  field :app_pre_release, 7, type: :string, json_name: "appPreRelease"
  field :build_tags, 8, repeated: true, type: :string, json_name: "buildTags"
  field :go_version, 9, type: :string, json_name: "goVersion"
end

defmodule Verrpc.Versioner.Service do
  @moduledoc false

  use GRPC.Service, name: "verrpc.Versioner", protoc_gen_elixir_version: "0.12.0"

  rpc :GetVersion, Verrpc.VersionRequest, Verrpc.Version
end

defmodule Verrpc.Versioner.Stub do
  @moduledoc false

  use GRPC.Stub, service: Verrpc.Versioner.Service
end