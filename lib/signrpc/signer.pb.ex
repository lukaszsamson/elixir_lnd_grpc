defmodule Signrpc.KeyLocator do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          key_family: integer,
          key_index: integer
        }

  defstruct [:key_family, :key_index]

  field :key_family, 1, type: :int32
  field :key_index, 2, type: :int32
end

defmodule Signrpc.KeyDescriptor do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          raw_key_bytes: binary,
          key_loc: Signrpc.KeyLocator.t() | nil
        }

  defstruct [:raw_key_bytes, :key_loc]

  field :raw_key_bytes, 1, type: :bytes
  field :key_loc, 2, type: Signrpc.KeyLocator
end

defmodule Signrpc.TxOut do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          value: integer,
          pk_script: binary
        }

  defstruct [:value, :pk_script]

  field :value, 1, type: :int64
  field :pk_script, 2, type: :bytes
end

defmodule Signrpc.SignDescriptor do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          key_desc: Signrpc.KeyDescriptor.t() | nil,
          single_tweak: binary,
          double_tweak: binary,
          witness_script: binary,
          output: Signrpc.TxOut.t() | nil,
          sighash: non_neg_integer,
          input_index: integer
        }

  defstruct [
    :key_desc,
    :single_tweak,
    :double_tweak,
    :witness_script,
    :output,
    :sighash,
    :input_index
  ]

  field :key_desc, 1, type: Signrpc.KeyDescriptor
  field :single_tweak, 2, type: :bytes
  field :double_tweak, 3, type: :bytes
  field :witness_script, 4, type: :bytes
  field :output, 5, type: Signrpc.TxOut
  field :sighash, 7, type: :uint32
  field :input_index, 8, type: :int32
end

defmodule Signrpc.SignReq do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          raw_tx_bytes: binary,
          sign_descs: [Signrpc.SignDescriptor.t()]
        }

  defstruct [:raw_tx_bytes, :sign_descs]

  field :raw_tx_bytes, 1, type: :bytes
  field :sign_descs, 2, repeated: true, type: Signrpc.SignDescriptor
end

defmodule Signrpc.SignResp do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          raw_sigs: [binary]
        }

  defstruct [:raw_sigs]

  field :raw_sigs, 1, repeated: true, type: :bytes
end

defmodule Signrpc.InputScript do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          witness: [binary],
          sig_script: binary
        }

  defstruct [:witness, :sig_script]

  field :witness, 1, repeated: true, type: :bytes
  field :sig_script, 2, type: :bytes
end

defmodule Signrpc.InputScriptResp do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          input_scripts: [Signrpc.InputScript.t()]
        }

  defstruct [:input_scripts]

  field :input_scripts, 1, repeated: true, type: Signrpc.InputScript
end

defmodule Signrpc.SignMessageReq do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          msg: binary,
          key_loc: Signrpc.KeyLocator.t() | nil
        }

  defstruct [:msg, :key_loc]

  field :msg, 1, type: :bytes
  field :key_loc, 2, type: Signrpc.KeyLocator
end

defmodule Signrpc.SignMessageResp do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          signature: binary
        }

  defstruct [:signature]

  field :signature, 1, type: :bytes
end

defmodule Signrpc.VerifyMessageReq do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          msg: binary,
          signature: binary,
          pubkey: binary
        }

  defstruct [:msg, :signature, :pubkey]

  field :msg, 1, type: :bytes
  field :signature, 2, type: :bytes
  field :pubkey, 3, type: :bytes
end

defmodule Signrpc.VerifyMessageResp do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          valid: boolean
        }

  defstruct [:valid]

  field :valid, 1, type: :bool
end

defmodule Signrpc.SharedKeyRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          ephemeral_pubkey: binary,
          key_loc: Signrpc.KeyLocator.t() | nil,
          key_desc: Signrpc.KeyDescriptor.t() | nil
        }

  defstruct [:ephemeral_pubkey, :key_loc, :key_desc]

  field :ephemeral_pubkey, 1, type: :bytes
  field :key_loc, 2, type: Signrpc.KeyLocator, deprecated: true
  field :key_desc, 3, type: Signrpc.KeyDescriptor
end

defmodule Signrpc.SharedKeyResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          shared_key: binary
        }

  defstruct [:shared_key]

  field :shared_key, 1, type: :bytes
end

defmodule Signrpc.Signer.Service do
  @moduledoc false
  use GRPC.Service, name: "signrpc.Signer"

  rpc :SignOutputRaw, Signrpc.SignReq, Signrpc.SignResp

  rpc :ComputeInputScript, Signrpc.SignReq, Signrpc.InputScriptResp

  rpc :SignMessage, Signrpc.SignMessageReq, Signrpc.SignMessageResp

  rpc :VerifyMessage, Signrpc.VerifyMessageReq, Signrpc.VerifyMessageResp

  rpc :DeriveSharedKey, Signrpc.SharedKeyRequest, Signrpc.SharedKeyResponse
end

defmodule Signrpc.Signer.Stub do
  @moduledoc false
  use GRPC.Stub, service: Signrpc.Signer.Service
end
