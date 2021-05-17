defmodule LndGrpc do
  @moduledoc """
  Documentation for `LndGrpc`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> LndGrpc.hello()
      :world

  """
  def hello do
    ca_path = Path.expand("~/.lnd-mac-mini/tls.cert")
    cred = GRPC.Credential.new(ssl: [cacertfile: ca_path])
    {:ok, channel} = GRPC.Stub.connect("192.168.0.28:10009", cred: cred)

    macaroon =
      Path.expand("~/.lnd-mac-mini/admin.macaroon")
      |> File.read!()
      |> Base.encode16()
      # |> String.trim()
      |> IO.inspect

    metadata = %{"macaroon" => macaroon}
    # Lnrpc.Lightning.Stub.get_info(channel, Lnrpc.GetInfoRequest.new(), metadata: metadata)
    # Lnrpc.Lightning.Stub.get_node_info(channel, Lnrpc.NodeInfoRequest.new(pub_key: "021f1beed0a32fb740e9c8ea12702dd4371b444a6464368d93a2957b95f8cd2db1"), metadata: metadata)
    Walletrpc.WalletKit.Stub.list_unspent(channel, Walletrpc.ListUnspentRequest.new(max_confs: 9999), metadata: metadata)
  end
end
