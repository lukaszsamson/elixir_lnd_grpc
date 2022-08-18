defmodule Devrpc.ImportGraphResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3
  @type t :: %__MODULE__{}

  defstruct []
end

defmodule Devrpc.Dev.Service do
  @moduledoc false
  use GRPC.Service, name: "devrpc.Dev"

  rpc :ImportGraph, Lnrpc.ChannelGraph, Devrpc.ImportGraphResponse
end

defmodule Devrpc.Dev.Stub do
  @moduledoc false
  use GRPC.Stub, service: Devrpc.Dev.Service
end
