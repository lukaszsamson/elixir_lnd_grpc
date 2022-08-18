defmodule Signrpc.SignMethod do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

  @type t ::
          integer
          | :SIGN_METHOD_WITNESS_V0
          | :SIGN_METHOD_TAPROOT_KEY_SPEND_BIP0086
          | :SIGN_METHOD_TAPROOT_KEY_SPEND
          | :SIGN_METHOD_TAPROOT_SCRIPT_SPEND

  field :SIGN_METHOD_WITNESS_V0, 0

  field :SIGN_METHOD_TAPROOT_KEY_SPEND_BIP0086, 1

  field :SIGN_METHOD_TAPROOT_KEY_SPEND, 2

  field :SIGN_METHOD_TAPROOT_SCRIPT_SPEND, 3
end

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
          tap_tweak: binary,
          witness_script: binary,
          output: Signrpc.TxOut.t() | nil,
          sighash: non_neg_integer,
          input_index: integer,
          sign_method: Signrpc.SignMethod.t()
        }

  defstruct [
    :key_desc,
    :single_tweak,
    :double_tweak,
    :tap_tweak,
    :witness_script,
    :output,
    :sighash,
    :input_index,
    :sign_method
  ]

  field :key_desc, 1, type: Signrpc.KeyDescriptor
  field :single_tweak, 2, type: :bytes
  field :double_tweak, 3, type: :bytes
  field :tap_tweak, 10, type: :bytes
  field :witness_script, 4, type: :bytes
  field :output, 5, type: Signrpc.TxOut
  field :sighash, 7, type: :uint32
  field :input_index, 8, type: :int32
  field :sign_method, 9, type: Signrpc.SignMethod, enum: true
end

defmodule Signrpc.SignReq do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          raw_tx_bytes: binary,
          sign_descs: [Signrpc.SignDescriptor.t()],
          prev_outputs: [Signrpc.TxOut.t()]
        }

  defstruct [:raw_tx_bytes, :sign_descs, :prev_outputs]

  field :raw_tx_bytes, 1, type: :bytes
  field :sign_descs, 2, repeated: true, type: Signrpc.SignDescriptor
  field :prev_outputs, 3, repeated: true, type: Signrpc.TxOut
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
          key_loc: Signrpc.KeyLocator.t() | nil,
          double_hash: boolean,
          compact_sig: boolean
        }

  defstruct [:msg, :key_loc, :double_hash, :compact_sig]

  field :msg, 1, type: :bytes
  field :key_loc, 2, type: Signrpc.KeyLocator
  field :double_hash, 3, type: :bool
  field :compact_sig, 4, type: :bool
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

defmodule Signrpc.TweakDesc do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          tweak: binary,
          is_x_only: boolean
        }

  defstruct [:tweak, :is_x_only]

  field :tweak, 1, type: :bytes
  field :is_x_only, 2, type: :bool
end

defmodule Signrpc.TaprootTweakDesc do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          script_root: binary,
          key_spend_only: boolean
        }

  defstruct [:script_root, :key_spend_only]

  field :script_root, 1, type: :bytes
  field :key_spend_only, 2, type: :bool
end

defmodule Signrpc.MuSig2CombineKeysRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          all_signer_pubkeys: [binary],
          tweaks: [Signrpc.TweakDesc.t()],
          taproot_tweak: Signrpc.TaprootTweakDesc.t() | nil
        }

  defstruct [:all_signer_pubkeys, :tweaks, :taproot_tweak]

  field :all_signer_pubkeys, 1, repeated: true, type: :bytes
  field :tweaks, 2, repeated: true, type: Signrpc.TweakDesc
  field :taproot_tweak, 3, type: Signrpc.TaprootTweakDesc
end

defmodule Signrpc.MuSig2CombineKeysResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          combined_key: binary,
          taproot_internal_key: binary
        }

  defstruct [:combined_key, :taproot_internal_key]

  field :combined_key, 1, type: :bytes
  field :taproot_internal_key, 2, type: :bytes
end

defmodule Signrpc.MuSig2SessionRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          key_loc: Signrpc.KeyLocator.t() | nil,
          all_signer_pubkeys: [binary],
          other_signer_public_nonces: [binary],
          tweaks: [Signrpc.TweakDesc.t()],
          taproot_tweak: Signrpc.TaprootTweakDesc.t() | nil
        }

  defstruct [:key_loc, :all_signer_pubkeys, :other_signer_public_nonces, :tweaks, :taproot_tweak]

  field :key_loc, 1, type: Signrpc.KeyLocator
  field :all_signer_pubkeys, 2, repeated: true, type: :bytes
  field :other_signer_public_nonces, 3, repeated: true, type: :bytes
  field :tweaks, 4, repeated: true, type: Signrpc.TweakDesc
  field :taproot_tweak, 5, type: Signrpc.TaprootTweakDesc
end

defmodule Signrpc.MuSig2SessionResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          session_id: binary,
          combined_key: binary,
          taproot_internal_key: binary,
          local_public_nonces: binary,
          have_all_nonces: boolean
        }

  defstruct [
    :session_id,
    :combined_key,
    :taproot_internal_key,
    :local_public_nonces,
    :have_all_nonces
  ]

  field :session_id, 1, type: :bytes
  field :combined_key, 2, type: :bytes
  field :taproot_internal_key, 3, type: :bytes
  field :local_public_nonces, 4, type: :bytes
  field :have_all_nonces, 5, type: :bool
end

defmodule Signrpc.MuSig2RegisterNoncesRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          session_id: binary,
          other_signer_public_nonces: [binary]
        }

  defstruct [:session_id, :other_signer_public_nonces]

  field :session_id, 1, type: :bytes
  field :other_signer_public_nonces, 3, repeated: true, type: :bytes
end

defmodule Signrpc.MuSig2RegisterNoncesResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          have_all_nonces: boolean
        }

  defstruct [:have_all_nonces]

  field :have_all_nonces, 1, type: :bool
end

defmodule Signrpc.MuSig2SignRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          session_id: binary,
          message_digest: binary,
          cleanup: boolean
        }

  defstruct [:session_id, :message_digest, :cleanup]

  field :session_id, 1, type: :bytes
  field :message_digest, 2, type: :bytes
  field :cleanup, 3, type: :bool
end

defmodule Signrpc.MuSig2SignResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          local_partial_signature: binary
        }

  defstruct [:local_partial_signature]

  field :local_partial_signature, 1, type: :bytes
end

defmodule Signrpc.MuSig2CombineSigRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          session_id: binary,
          other_partial_signatures: [binary]
        }

  defstruct [:session_id, :other_partial_signatures]

  field :session_id, 1, type: :bytes
  field :other_partial_signatures, 2, repeated: true, type: :bytes
end

defmodule Signrpc.MuSig2CombineSigResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          have_all_signatures: boolean,
          final_signature: binary
        }

  defstruct [:have_all_signatures, :final_signature]

  field :have_all_signatures, 1, type: :bool
  field :final_signature, 2, type: :bytes
end

defmodule Signrpc.MuSig2CleanupRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          session_id: binary
        }

  defstruct [:session_id]

  field :session_id, 1, type: :bytes
end

defmodule Signrpc.MuSig2CleanupResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3
  @type t :: %__MODULE__{}

  defstruct []
end

defmodule Signrpc.Signer.Service do
  @moduledoc false
  use GRPC.Service, name: "signrpc.Signer"

  rpc :SignOutputRaw, Signrpc.SignReq, Signrpc.SignResp

  rpc :ComputeInputScript, Signrpc.SignReq, Signrpc.InputScriptResp

  rpc :SignMessage, Signrpc.SignMessageReq, Signrpc.SignMessageResp

  rpc :VerifyMessage, Signrpc.VerifyMessageReq, Signrpc.VerifyMessageResp

  rpc :DeriveSharedKey, Signrpc.SharedKeyRequest, Signrpc.SharedKeyResponse

  rpc :MuSig2CombineKeys, Signrpc.MuSig2CombineKeysRequest, Signrpc.MuSig2CombineKeysResponse

  rpc :MuSig2CreateSession, Signrpc.MuSig2SessionRequest, Signrpc.MuSig2SessionResponse

  rpc :MuSig2RegisterNonces,
      Signrpc.MuSig2RegisterNoncesRequest,
      Signrpc.MuSig2RegisterNoncesResponse

  rpc :MuSig2Sign, Signrpc.MuSig2SignRequest, Signrpc.MuSig2SignResponse

  rpc :MuSig2CombineSig, Signrpc.MuSig2CombineSigRequest, Signrpc.MuSig2CombineSigResponse

  rpc :MuSig2Cleanup, Signrpc.MuSig2CleanupRequest, Signrpc.MuSig2CleanupResponse
end

defmodule Signrpc.Signer.Stub do
  @moduledoc false
  use GRPC.Stub, service: Signrpc.Signer.Service
end
