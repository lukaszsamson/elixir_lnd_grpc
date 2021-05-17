defmodule LndGrpcTest do
  use ExUnit.Case
  doctest LndGrpc

  test "greets the world" do
    assert LndGrpc.hello() == :world
  end
end
