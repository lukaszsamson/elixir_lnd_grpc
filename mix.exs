defmodule LndGrpc.MixProject do
  use Mix.Project

  def project do
    [
      app: :lnd_grpc,
      version: "0.1.0",
      elixir: "~> 1.11",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      # TODO switch to "elixir-grpc/grpc" when
      # https://github.com/elixir-grpc/grpc/pull/175 merged or
      # https://github.com/elixir-grpc/grpc/issues/188 fixed
      # {:grpc, github: "frekw/grpc", branch: "fix/handle-rpc-errors-in-recv"},
      {:grpc, github: "elixir-grpc/grpc"},
      {:protobuf, "~> 0.7"},
      {:gun,
       github: "ninenines/gun", ref: "b28950d5e701055f536f66c70b581c3cf806f3dd", override: true},
      {:cowlib, "~> 2.9.1", override: true},
    ]
  end
end
