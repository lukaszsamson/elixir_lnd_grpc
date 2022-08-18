defmodule Lnrpc.GenSeedRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.0", syntax: :proto3

  field :aezeed_passphrase, 1, type: :bytes, json_name: "aezeedPassphrase"
  field :seed_entropy, 2, type: :bytes, json_name: "seedEntropy"
end
defmodule Lnrpc.GenSeedResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.0", syntax: :proto3

  field :cipher_seed_mnemonic, 1, repeated: true, type: :string, json_name: "cipherSeedMnemonic"
  field :enciphered_seed, 2, type: :bytes, json_name: "encipheredSeed"
end
defmodule Lnrpc.InitWalletRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.0", syntax: :proto3

  field :wallet_password, 1, type: :bytes, json_name: "walletPassword"
  field :cipher_seed_mnemonic, 2, repeated: true, type: :string, json_name: "cipherSeedMnemonic"
  field :aezeed_passphrase, 3, type: :bytes, json_name: "aezeedPassphrase"
  field :recovery_window, 4, type: :int32, json_name: "recoveryWindow"
  field :channel_backups, 5, type: Lnrpc.ChanBackupSnapshot, json_name: "channelBackups"
  field :stateless_init, 6, type: :bool, json_name: "statelessInit"
  field :extended_master_key, 7, type: :string, json_name: "extendedMasterKey"

  field :extended_master_key_birthday_timestamp, 8,
    type: :uint64,
    json_name: "extendedMasterKeyBirthdayTimestamp"

  field :watch_only, 9, type: Lnrpc.WatchOnly, json_name: "watchOnly"
end
defmodule Lnrpc.InitWalletResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.0", syntax: :proto3

  field :admin_macaroon, 1, type: :bytes, json_name: "adminMacaroon"
end
defmodule Lnrpc.WatchOnly do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.0", syntax: :proto3

  field :master_key_birthday_timestamp, 1, type: :uint64, json_name: "masterKeyBirthdayTimestamp"
  field :master_key_fingerprint, 2, type: :bytes, json_name: "masterKeyFingerprint"
  field :accounts, 3, repeated: true, type: Lnrpc.WatchOnlyAccount
end
defmodule Lnrpc.WatchOnlyAccount do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.0", syntax: :proto3

  field :purpose, 1, type: :uint32
  field :coin_type, 2, type: :uint32, json_name: "coinType"
  field :account, 3, type: :uint32
  field :xpub, 4, type: :string
end
defmodule Lnrpc.UnlockWalletRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.0", syntax: :proto3

  field :wallet_password, 1, type: :bytes, json_name: "walletPassword"
  field :recovery_window, 2, type: :int32, json_name: "recoveryWindow"
  field :channel_backups, 3, type: Lnrpc.ChanBackupSnapshot, json_name: "channelBackups"
  field :stateless_init, 4, type: :bool, json_name: "statelessInit"
end
defmodule Lnrpc.UnlockWalletResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.0", syntax: :proto3
end
defmodule Lnrpc.ChangePasswordRequest do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.0", syntax: :proto3

  field :current_password, 1, type: :bytes, json_name: "currentPassword"
  field :new_password, 2, type: :bytes, json_name: "newPassword"
  field :stateless_init, 3, type: :bool, json_name: "statelessInit"
  field :new_macaroon_root_key, 4, type: :bool, json_name: "newMacaroonRootKey"
end
defmodule Lnrpc.ChangePasswordResponse do
  @moduledoc false
  use Protobuf, protoc_gen_elixir_version: "0.10.0", syntax: :proto3

  field :admin_macaroon, 1, type: :bytes, json_name: "adminMacaroon"
end
defmodule Lnrpc.WalletUnlocker.Service do
  @moduledoc false
  use GRPC.Service, name: "lnrpc.WalletUnlocker", protoc_gen_elixir_version: "0.10.0"

  rpc :GenSeed, Lnrpc.GenSeedRequest, Lnrpc.GenSeedResponse

  rpc :InitWallet, Lnrpc.InitWalletRequest, Lnrpc.InitWalletResponse

  rpc :UnlockWallet, Lnrpc.UnlockWalletRequest, Lnrpc.UnlockWalletResponse

  rpc :ChangePassword, Lnrpc.ChangePasswordRequest, Lnrpc.ChangePasswordResponse
end

defmodule Lnrpc.WalletUnlocker.Stub do
  @moduledoc false
  use GRPC.Stub, service: Lnrpc.WalletUnlocker.Service
end
