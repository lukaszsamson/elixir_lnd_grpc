defmodule Lnrpc.GenSeedRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          aezeed_passphrase: binary,
          seed_entropy: binary
        }

  defstruct [:aezeed_passphrase, :seed_entropy]

  field :aezeed_passphrase, 1, type: :bytes
  field :seed_entropy, 2, type: :bytes
end

defmodule Lnrpc.GenSeedResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          cipher_seed_mnemonic: [String.t()],
          enciphered_seed: binary
        }

  defstruct [:cipher_seed_mnemonic, :enciphered_seed]

  field :cipher_seed_mnemonic, 1, repeated: true, type: :string
  field :enciphered_seed, 2, type: :bytes
end

defmodule Lnrpc.InitWalletRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          wallet_password: binary,
          cipher_seed_mnemonic: [String.t()],
          aezeed_passphrase: binary,
          recovery_window: integer,
          channel_backups: Lnrpc.ChanBackupSnapshot.t() | nil,
          stateless_init: boolean
        }

  defstruct [
    :wallet_password,
    :cipher_seed_mnemonic,
    :aezeed_passphrase,
    :recovery_window,
    :channel_backups,
    :stateless_init
  ]

  field :wallet_password, 1, type: :bytes
  field :cipher_seed_mnemonic, 2, repeated: true, type: :string
  field :aezeed_passphrase, 3, type: :bytes
  field :recovery_window, 4, type: :int32
  field :channel_backups, 5, type: Lnrpc.ChanBackupSnapshot
  field :stateless_init, 6, type: :bool
end

defmodule Lnrpc.InitWalletResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          admin_macaroon: binary
        }

  defstruct [:admin_macaroon]

  field :admin_macaroon, 1, type: :bytes
end

defmodule Lnrpc.UnlockWalletRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          wallet_password: binary,
          recovery_window: integer,
          channel_backups: Lnrpc.ChanBackupSnapshot.t() | nil,
          stateless_init: boolean
        }

  defstruct [:wallet_password, :recovery_window, :channel_backups, :stateless_init]

  field :wallet_password, 1, type: :bytes
  field :recovery_window, 2, type: :int32
  field :channel_backups, 3, type: Lnrpc.ChanBackupSnapshot
  field :stateless_init, 4, type: :bool
end

defmodule Lnrpc.UnlockWalletResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3
  @type t :: %__MODULE__{}

  defstruct []
end

defmodule Lnrpc.ChangePasswordRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          current_password: binary,
          new_password: binary,
          stateless_init: boolean,
          new_macaroon_root_key: boolean
        }

  defstruct [:current_password, :new_password, :stateless_init, :new_macaroon_root_key]

  field :current_password, 1, type: :bytes
  field :new_password, 2, type: :bytes
  field :stateless_init, 3, type: :bool
  field :new_macaroon_root_key, 4, type: :bool
end

defmodule Lnrpc.ChangePasswordResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          admin_macaroon: binary
        }

  defstruct [:admin_macaroon]

  field :admin_macaroon, 1, type: :bytes
end

defmodule Lnrpc.WalletUnlocker.Service do
  @moduledoc false
  use GRPC.Service, name: "lnrpc.WalletUnlocker"

  rpc :GenSeed, Lnrpc.GenSeedRequest, Lnrpc.GenSeedResponse

  rpc :InitWallet, Lnrpc.InitWalletRequest, Lnrpc.InitWalletResponse

  rpc :UnlockWallet, Lnrpc.UnlockWalletRequest, Lnrpc.UnlockWalletResponse

  rpc :ChangePassword, Lnrpc.ChangePasswordRequest, Lnrpc.ChangePasswordResponse
end

defmodule Lnrpc.WalletUnlocker.Stub do
  @moduledoc false
  use GRPC.Stub, service: Lnrpc.WalletUnlocker.Service
end
