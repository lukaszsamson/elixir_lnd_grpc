defmodule Signrpc.SignMethod do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "signrpc.SignMethod",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :SIGN_METHOD_WITNESS_V0, 0
  field :SIGN_METHOD_TAPROOT_KEY_SPEND_BIP0086, 1
  field :SIGN_METHOD_TAPROOT_KEY_SPEND, 2
  field :SIGN_METHOD_TAPROOT_SCRIPT_SPEND, 3
end

defmodule Signrpc.MuSig2Version do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "signrpc.MuSig2Version",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :MUSIG2_VERSION_UNDEFINED, 0
  field :MUSIG2_VERSION_V040, 1
  field :MUSIG2_VERSION_V100RC2, 2
end

defmodule Signrpc.KeyLocator do
  @moduledoc false

  use Protobuf,
    full_name: "signrpc.KeyLocator",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :key_family, 1, type: :int32, json_name: "keyFamily"
  field :key_index, 2, type: :int32, json_name: "keyIndex"
end

defmodule Signrpc.KeyDescriptor do
  @moduledoc false

  use Protobuf,
    full_name: "signrpc.KeyDescriptor",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :raw_key_bytes, 1, type: :bytes, json_name: "rawKeyBytes"
  field :key_loc, 2, type: Signrpc.KeyLocator, json_name: "keyLoc"
end

defmodule Signrpc.TxOut do
  @moduledoc false

  use Protobuf, full_name: "signrpc.TxOut", protoc_gen_elixir_version: "0.17.1", syntax: :proto3

  field :value, 1, type: :int64
  field :pk_script, 2, type: :bytes, json_name: "pkScript"
end

defmodule Signrpc.SignDescriptor do
  @moduledoc false

  use Protobuf,
    full_name: "signrpc.SignDescriptor",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :key_desc, 1, type: Signrpc.KeyDescriptor, json_name: "keyDesc"
  field :single_tweak, 2, type: :bytes, json_name: "singleTweak"
  field :double_tweak, 3, type: :bytes, json_name: "doubleTweak"
  field :tap_tweak, 10, type: :bytes, json_name: "tapTweak"
  field :witness_script, 4, type: :bytes, json_name: "witnessScript"
  field :output, 5, type: Signrpc.TxOut
  field :sighash, 7, type: :uint32
  field :input_index, 8, type: :int32, json_name: "inputIndex"
  field :sign_method, 9, type: Signrpc.SignMethod, json_name: "signMethod", enum: true
end

defmodule Signrpc.SignReq do
  @moduledoc false

  use Protobuf, full_name: "signrpc.SignReq", protoc_gen_elixir_version: "0.17.1", syntax: :proto3

  field :raw_tx_bytes, 1, type: :bytes, json_name: "rawTxBytes"
  field :sign_descs, 2, repeated: true, type: Signrpc.SignDescriptor, json_name: "signDescs"
  field :prev_outputs, 3, repeated: true, type: Signrpc.TxOut, json_name: "prevOutputs"
end

defmodule Signrpc.SignResp do
  @moduledoc false

  use Protobuf,
    full_name: "signrpc.SignResp",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :raw_sigs, 1, repeated: true, type: :bytes, json_name: "rawSigs"
end

defmodule Signrpc.InputScript do
  @moduledoc false

  use Protobuf,
    full_name: "signrpc.InputScript",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :witness, 1, repeated: true, type: :bytes
  field :sig_script, 2, type: :bytes, json_name: "sigScript"
end

defmodule Signrpc.InputScriptResp do
  @moduledoc false

  use Protobuf,
    full_name: "signrpc.InputScriptResp",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :input_scripts, 1, repeated: true, type: Signrpc.InputScript, json_name: "inputScripts"
end

defmodule Signrpc.SignMessageReq do
  @moduledoc false

  use Protobuf,
    full_name: "signrpc.SignMessageReq",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :msg, 1, type: :bytes
  field :key_loc, 2, type: Signrpc.KeyLocator, json_name: "keyLoc"
  field :double_hash, 3, type: :bool, json_name: "doubleHash"
  field :compact_sig, 4, type: :bool, json_name: "compactSig"
  field :schnorr_sig, 5, type: :bool, json_name: "schnorrSig"
  field :schnorr_sig_tap_tweak, 6, type: :bytes, json_name: "schnorrSigTapTweak"
  field :tag, 7, type: :bytes
end

defmodule Signrpc.SignMessageResp do
  @moduledoc false

  use Protobuf,
    full_name: "signrpc.SignMessageResp",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :signature, 1, type: :bytes
end

defmodule Signrpc.VerifyMessageReq do
  @moduledoc false

  use Protobuf,
    full_name: "signrpc.VerifyMessageReq",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :msg, 1, type: :bytes
  field :signature, 2, type: :bytes
  field :pubkey, 3, type: :bytes
  field :is_schnorr_sig, 4, type: :bool, json_name: "isSchnorrSig"
  field :tag, 5, type: :bytes
end

defmodule Signrpc.VerifyMessageResp do
  @moduledoc false

  use Protobuf,
    full_name: "signrpc.VerifyMessageResp",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :valid, 1, type: :bool
end

defmodule Signrpc.SharedKeyRequest do
  @moduledoc false

  use Protobuf,
    full_name: "signrpc.SharedKeyRequest",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :ephemeral_pubkey, 1, type: :bytes, json_name: "ephemeralPubkey"
  field :key_loc, 2, type: Signrpc.KeyLocator, json_name: "keyLoc", deprecated: true
  field :key_desc, 3, type: Signrpc.KeyDescriptor, json_name: "keyDesc"
end

defmodule Signrpc.SharedKeyResponse do
  @moduledoc false

  use Protobuf,
    full_name: "signrpc.SharedKeyResponse",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :shared_key, 1, type: :bytes, json_name: "sharedKey"
end

defmodule Signrpc.TweakDesc do
  @moduledoc false

  use Protobuf,
    full_name: "signrpc.TweakDesc",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :tweak, 1, type: :bytes
  field :is_x_only, 2, type: :bool, json_name: "isXOnly"
end

defmodule Signrpc.TaprootTweakDesc do
  @moduledoc false

  use Protobuf,
    full_name: "signrpc.TaprootTweakDesc",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :script_root, 1, type: :bytes, json_name: "scriptRoot"
  field :key_spend_only, 2, type: :bool, json_name: "keySpendOnly"
end

defmodule Signrpc.MuSig2CombineKeysRequest do
  @moduledoc false

  use Protobuf,
    full_name: "signrpc.MuSig2CombineKeysRequest",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :all_signer_pubkeys, 1, repeated: true, type: :bytes, json_name: "allSignerPubkeys"
  field :tweaks, 2, repeated: true, type: Signrpc.TweakDesc
  field :taproot_tweak, 3, type: Signrpc.TaprootTweakDesc, json_name: "taprootTweak"
  field :version, 4, type: Signrpc.MuSig2Version, enum: true
end

defmodule Signrpc.MuSig2CombineKeysResponse do
  @moduledoc false

  use Protobuf,
    full_name: "signrpc.MuSig2CombineKeysResponse",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :combined_key, 1, type: :bytes, json_name: "combinedKey"
  field :taproot_internal_key, 2, type: :bytes, json_name: "taprootInternalKey"
  field :version, 4, type: Signrpc.MuSig2Version, enum: true
end

defmodule Signrpc.MuSig2SessionRequest do
  @moduledoc false

  use Protobuf,
    full_name: "signrpc.MuSig2SessionRequest",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :key_loc, 1, type: Signrpc.KeyLocator, json_name: "keyLoc"
  field :all_signer_pubkeys, 2, repeated: true, type: :bytes, json_name: "allSignerPubkeys"

  field :other_signer_public_nonces, 3,
    repeated: true,
    type: :bytes,
    json_name: "otherSignerPublicNonces"

  field :tweaks, 4, repeated: true, type: Signrpc.TweakDesc
  field :taproot_tweak, 5, type: Signrpc.TaprootTweakDesc, json_name: "taprootTweak"
  field :version, 6, type: Signrpc.MuSig2Version, enum: true
  field :pregenerated_local_nonce, 7, type: :bytes, json_name: "pregeneratedLocalNonce"
end

defmodule Signrpc.MuSig2SessionResponse do
  @moduledoc false

  use Protobuf,
    full_name: "signrpc.MuSig2SessionResponse",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :session_id, 1, type: :bytes, json_name: "sessionId"
  field :combined_key, 2, type: :bytes, json_name: "combinedKey"
  field :taproot_internal_key, 3, type: :bytes, json_name: "taprootInternalKey"
  field :local_public_nonces, 4, type: :bytes, json_name: "localPublicNonces"
  field :have_all_nonces, 5, type: :bool, json_name: "haveAllNonces"
  field :version, 6, type: Signrpc.MuSig2Version, enum: true
end

defmodule Signrpc.MuSig2RegisterNoncesRequest do
  @moduledoc false

  use Protobuf,
    full_name: "signrpc.MuSig2RegisterNoncesRequest",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :session_id, 1, type: :bytes, json_name: "sessionId"

  field :other_signer_public_nonces, 3,
    repeated: true,
    type: :bytes,
    json_name: "otherSignerPublicNonces"
end

defmodule Signrpc.MuSig2RegisterNoncesResponse do
  @moduledoc false

  use Protobuf,
    full_name: "signrpc.MuSig2RegisterNoncesResponse",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :have_all_nonces, 1, type: :bool, json_name: "haveAllNonces"
end

defmodule Signrpc.MuSig2SignRequest do
  @moduledoc false

  use Protobuf,
    full_name: "signrpc.MuSig2SignRequest",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :session_id, 1, type: :bytes, json_name: "sessionId"
  field :message_digest, 2, type: :bytes, json_name: "messageDigest"
  field :cleanup, 3, type: :bool
end

defmodule Signrpc.MuSig2SignResponse do
  @moduledoc false

  use Protobuf,
    full_name: "signrpc.MuSig2SignResponse",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :local_partial_signature, 1, type: :bytes, json_name: "localPartialSignature"
end

defmodule Signrpc.MuSig2CombineSigRequest do
  @moduledoc false

  use Protobuf,
    full_name: "signrpc.MuSig2CombineSigRequest",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :session_id, 1, type: :bytes, json_name: "sessionId"

  field :other_partial_signatures, 2,
    repeated: true,
    type: :bytes,
    json_name: "otherPartialSignatures"
end

defmodule Signrpc.MuSig2CombineSigResponse do
  @moduledoc false

  use Protobuf,
    full_name: "signrpc.MuSig2CombineSigResponse",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :have_all_signatures, 1, type: :bool, json_name: "haveAllSignatures"
  field :final_signature, 2, type: :bytes, json_name: "finalSignature"
end

defmodule Signrpc.MuSig2CleanupRequest do
  @moduledoc false

  use Protobuf,
    full_name: "signrpc.MuSig2CleanupRequest",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :session_id, 1, type: :bytes, json_name: "sessionId"
end

defmodule Signrpc.MuSig2CleanupResponse do
  @moduledoc false

  use Protobuf,
    full_name: "signrpc.MuSig2CleanupResponse",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3
end

defmodule Signrpc.Signer.Service do
  @moduledoc false

  use GRPC.Service, name: "signrpc.Signer", protoc_gen_elixir_version: "0.17.1"

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
