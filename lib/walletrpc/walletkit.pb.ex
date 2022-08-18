defmodule Walletrpc.AddressType do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

  @type t ::
          integer
          | :UNKNOWN
          | :WITNESS_PUBKEY_HASH
          | :NESTED_WITNESS_PUBKEY_HASH
          | :HYBRID_NESTED_WITNESS_PUBKEY_HASH
          | :TAPROOT_PUBKEY

  field :UNKNOWN, 0

  field :WITNESS_PUBKEY_HASH, 1

  field :NESTED_WITNESS_PUBKEY_HASH, 2

  field :HYBRID_NESTED_WITNESS_PUBKEY_HASH, 3

  field :TAPROOT_PUBKEY, 4
end

defmodule Walletrpc.WitnessType do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3

  @type t ::
          integer
          | :UNKNOWN_WITNESS
          | :COMMITMENT_TIME_LOCK
          | :COMMITMENT_NO_DELAY
          | :COMMITMENT_REVOKE
          | :HTLC_OFFERED_REVOKE
          | :HTLC_ACCEPTED_REVOKE
          | :HTLC_OFFERED_TIMEOUT_SECOND_LEVEL
          | :HTLC_ACCEPTED_SUCCESS_SECOND_LEVEL
          | :HTLC_OFFERED_REMOTE_TIMEOUT
          | :HTLC_ACCEPTED_REMOTE_SUCCESS
          | :HTLC_SECOND_LEVEL_REVOKE
          | :WITNESS_KEY_HASH
          | :NESTED_WITNESS_KEY_HASH
          | :COMMITMENT_ANCHOR

  field :UNKNOWN_WITNESS, 0

  field :COMMITMENT_TIME_LOCK, 1

  field :COMMITMENT_NO_DELAY, 2

  field :COMMITMENT_REVOKE, 3

  field :HTLC_OFFERED_REVOKE, 4

  field :HTLC_ACCEPTED_REVOKE, 5

  field :HTLC_OFFERED_TIMEOUT_SECOND_LEVEL, 6

  field :HTLC_ACCEPTED_SUCCESS_SECOND_LEVEL, 7

  field :HTLC_OFFERED_REMOTE_TIMEOUT, 8

  field :HTLC_ACCEPTED_REMOTE_SUCCESS, 9

  field :HTLC_SECOND_LEVEL_REVOKE, 10

  field :WITNESS_KEY_HASH, 11

  field :NESTED_WITNESS_KEY_HASH, 12

  field :COMMITMENT_ANCHOR, 13
end

defmodule Walletrpc.ListUnspentRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          min_confs: integer,
          max_confs: integer,
          account: String.t(),
          unconfirmed_only: boolean
        }

  defstruct [:min_confs, :max_confs, :account, :unconfirmed_only]

  field :min_confs, 1, type: :int32
  field :max_confs, 2, type: :int32
  field :account, 3, type: :string
  field :unconfirmed_only, 4, type: :bool
end

defmodule Walletrpc.ListUnspentResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          utxos: [Lnrpc.Utxo.t()]
        }

  defstruct [:utxos]

  field :utxos, 1, repeated: true, type: Lnrpc.Utxo
end

defmodule Walletrpc.LeaseOutputRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: binary,
          outpoint: Lnrpc.OutPoint.t() | nil,
          expiration_seconds: non_neg_integer
        }

  defstruct [:id, :outpoint, :expiration_seconds]

  field :id, 1, type: :bytes
  field :outpoint, 2, type: Lnrpc.OutPoint
  field :expiration_seconds, 3, type: :uint64
end

defmodule Walletrpc.LeaseOutputResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          expiration: non_neg_integer
        }

  defstruct [:expiration]

  field :expiration, 1, type: :uint64
end

defmodule Walletrpc.ReleaseOutputRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: binary,
          outpoint: Lnrpc.OutPoint.t() | nil
        }

  defstruct [:id, :outpoint]

  field :id, 1, type: :bytes
  field :outpoint, 2, type: Lnrpc.OutPoint
end

defmodule Walletrpc.ReleaseOutputResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3
  @type t :: %__MODULE__{}

  defstruct []
end

defmodule Walletrpc.KeyReq do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          key_finger_print: integer,
          key_family: integer
        }

  defstruct [:key_finger_print, :key_family]

  field :key_finger_print, 1, type: :int32
  field :key_family, 2, type: :int32
end

defmodule Walletrpc.AddrRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          account: String.t(),
          type: Walletrpc.AddressType.t(),
          change: boolean
        }

  defstruct [:account, :type, :change]

  field :account, 1, type: :string
  field :type, 2, type: Walletrpc.AddressType, enum: true
  field :change, 3, type: :bool
end

defmodule Walletrpc.AddrResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          addr: String.t()
        }

  defstruct [:addr]

  field :addr, 1, type: :string
end

defmodule Walletrpc.Account do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          name: String.t(),
          address_type: Walletrpc.AddressType.t(),
          extended_public_key: String.t(),
          master_key_fingerprint: binary,
          derivation_path: String.t(),
          external_key_count: non_neg_integer,
          internal_key_count: non_neg_integer,
          watch_only: boolean
        }

  defstruct [
    :name,
    :address_type,
    :extended_public_key,
    :master_key_fingerprint,
    :derivation_path,
    :external_key_count,
    :internal_key_count,
    :watch_only
  ]

  field :name, 1, type: :string
  field :address_type, 2, type: Walletrpc.AddressType, enum: true
  field :extended_public_key, 3, type: :string
  field :master_key_fingerprint, 4, type: :bytes
  field :derivation_path, 5, type: :string
  field :external_key_count, 6, type: :uint32
  field :internal_key_count, 7, type: :uint32
  field :watch_only, 8, type: :bool
end

defmodule Walletrpc.ListAccountsRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          name: String.t(),
          address_type: Walletrpc.AddressType.t()
        }

  defstruct [:name, :address_type]

  field :name, 1, type: :string
  field :address_type, 2, type: Walletrpc.AddressType, enum: true
end

defmodule Walletrpc.ListAccountsResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          accounts: [Walletrpc.Account.t()]
        }

  defstruct [:accounts]

  field :accounts, 1, repeated: true, type: Walletrpc.Account
end

defmodule Walletrpc.ImportAccountRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          name: String.t(),
          extended_public_key: String.t(),
          master_key_fingerprint: binary,
          address_type: Walletrpc.AddressType.t(),
          dry_run: boolean
        }

  defstruct [:name, :extended_public_key, :master_key_fingerprint, :address_type, :dry_run]

  field :name, 1, type: :string
  field :extended_public_key, 2, type: :string
  field :master_key_fingerprint, 3, type: :bytes
  field :address_type, 4, type: Walletrpc.AddressType, enum: true
  field :dry_run, 5, type: :bool
end

defmodule Walletrpc.ImportAccountResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          account: Walletrpc.Account.t() | nil,
          dry_run_external_addrs: [String.t()],
          dry_run_internal_addrs: [String.t()]
        }

  defstruct [:account, :dry_run_external_addrs, :dry_run_internal_addrs]

  field :account, 1, type: Walletrpc.Account
  field :dry_run_external_addrs, 2, repeated: true, type: :string
  field :dry_run_internal_addrs, 3, repeated: true, type: :string
end

defmodule Walletrpc.ImportPublicKeyRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          public_key: binary,
          address_type: Walletrpc.AddressType.t()
        }

  defstruct [:public_key, :address_type]

  field :public_key, 1, type: :bytes
  field :address_type, 2, type: Walletrpc.AddressType, enum: true
end

defmodule Walletrpc.ImportPublicKeyResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3
  @type t :: %__MODULE__{}

  defstruct []
end

defmodule Walletrpc.Transaction do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          tx_hex: binary,
          label: String.t()
        }

  defstruct [:tx_hex, :label]

  field :tx_hex, 1, type: :bytes
  field :label, 2, type: :string
end

defmodule Walletrpc.PublishResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          publish_error: String.t()
        }

  defstruct [:publish_error]

  field :publish_error, 1, type: :string
end

defmodule Walletrpc.SendOutputsRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          sat_per_kw: integer,
          outputs: [Signrpc.TxOut.t()],
          label: String.t(),
          min_confs: integer,
          spend_unconfirmed: boolean
        }

  defstruct [:sat_per_kw, :outputs, :label, :min_confs, :spend_unconfirmed]

  field :sat_per_kw, 1, type: :int64
  field :outputs, 2, repeated: true, type: Signrpc.TxOut
  field :label, 3, type: :string
  field :min_confs, 4, type: :int32
  field :spend_unconfirmed, 5, type: :bool
end

defmodule Walletrpc.SendOutputsResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          raw_tx: binary
        }

  defstruct [:raw_tx]

  field :raw_tx, 1, type: :bytes
end

defmodule Walletrpc.EstimateFeeRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          conf_target: integer
        }

  defstruct [:conf_target]

  field :conf_target, 1, type: :int32
end

defmodule Walletrpc.EstimateFeeResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          sat_per_kw: integer
        }

  defstruct [:sat_per_kw]

  field :sat_per_kw, 1, type: :int64
end

defmodule Walletrpc.PendingSweep do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          outpoint: Lnrpc.OutPoint.t() | nil,
          witness_type: Walletrpc.WitnessType.t(),
          amount_sat: non_neg_integer,
          sat_per_byte: non_neg_integer,
          broadcast_attempts: non_neg_integer,
          next_broadcast_height: non_neg_integer,
          requested_conf_target: non_neg_integer,
          requested_sat_per_byte: non_neg_integer,
          sat_per_vbyte: non_neg_integer,
          requested_sat_per_vbyte: non_neg_integer,
          force: boolean
        }

  defstruct [
    :outpoint,
    :witness_type,
    :amount_sat,
    :sat_per_byte,
    :broadcast_attempts,
    :next_broadcast_height,
    :requested_conf_target,
    :requested_sat_per_byte,
    :sat_per_vbyte,
    :requested_sat_per_vbyte,
    :force
  ]

  field :outpoint, 1, type: Lnrpc.OutPoint
  field :witness_type, 2, type: Walletrpc.WitnessType, enum: true
  field :amount_sat, 3, type: :uint32
  field :sat_per_byte, 4, type: :uint32, deprecated: true
  field :broadcast_attempts, 5, type: :uint32
  field :next_broadcast_height, 6, type: :uint32
  field :requested_conf_target, 8, type: :uint32
  field :requested_sat_per_byte, 9, type: :uint32, deprecated: true
  field :sat_per_vbyte, 10, type: :uint64
  field :requested_sat_per_vbyte, 11, type: :uint64
  field :force, 7, type: :bool
end

defmodule Walletrpc.PendingSweepsRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3
  @type t :: %__MODULE__{}

  defstruct []
end

defmodule Walletrpc.PendingSweepsResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          pending_sweeps: [Walletrpc.PendingSweep.t()]
        }

  defstruct [:pending_sweeps]

  field :pending_sweeps, 1, repeated: true, type: Walletrpc.PendingSweep
end

defmodule Walletrpc.BumpFeeRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          outpoint: Lnrpc.OutPoint.t() | nil,
          target_conf: non_neg_integer,
          sat_per_byte: non_neg_integer,
          force: boolean,
          sat_per_vbyte: non_neg_integer
        }

  defstruct [:outpoint, :target_conf, :sat_per_byte, :force, :sat_per_vbyte]

  field :outpoint, 1, type: Lnrpc.OutPoint
  field :target_conf, 2, type: :uint32
  field :sat_per_byte, 3, type: :uint32, deprecated: true
  field :force, 4, type: :bool
  field :sat_per_vbyte, 5, type: :uint64
end

defmodule Walletrpc.BumpFeeResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3
  @type t :: %__MODULE__{}

  defstruct []
end

defmodule Walletrpc.ListSweepsRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          verbose: boolean
        }

  defstruct [:verbose]

  field :verbose, 1, type: :bool
end

defmodule Walletrpc.ListSweepsResponse.TransactionIDs do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          transaction_ids: [String.t()]
        }

  defstruct [:transaction_ids]

  field :transaction_ids, 1, repeated: true, type: :string
end

defmodule Walletrpc.ListSweepsResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          sweeps: {atom, any}
        }

  defstruct [:sweeps]

  oneof :sweeps, 0
  field :transaction_details, 1, type: Lnrpc.TransactionDetails, oneof: 0
  field :transaction_ids, 2, type: Walletrpc.ListSweepsResponse.TransactionIDs, oneof: 0
end

defmodule Walletrpc.LabelTransactionRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          txid: binary,
          label: String.t(),
          overwrite: boolean
        }

  defstruct [:txid, :label, :overwrite]

  field :txid, 1, type: :bytes
  field :label, 2, type: :string
  field :overwrite, 3, type: :bool
end

defmodule Walletrpc.LabelTransactionResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3
  @type t :: %__MODULE__{}

  defstruct []
end

defmodule Walletrpc.FundPsbtRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          template: {atom, any},
          fees: {atom, any},
          account: String.t(),
          min_confs: integer,
          spend_unconfirmed: boolean
        }

  defstruct [:template, :fees, :account, :min_confs, :spend_unconfirmed]

  oneof :template, 0
  oneof :fees, 1
  field :psbt, 1, type: :bytes, oneof: 0
  field :raw, 2, type: Walletrpc.TxTemplate, oneof: 0
  field :target_conf, 3, type: :uint32, oneof: 1
  field :sat_per_vbyte, 4, type: :uint64, oneof: 1
  field :account, 5, type: :string
  field :min_confs, 6, type: :int32
  field :spend_unconfirmed, 7, type: :bool
end

defmodule Walletrpc.FundPsbtResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          funded_psbt: binary,
          change_output_index: integer,
          locked_utxos: [Walletrpc.UtxoLease.t()]
        }

  defstruct [:funded_psbt, :change_output_index, :locked_utxos]

  field :funded_psbt, 1, type: :bytes
  field :change_output_index, 2, type: :int32
  field :locked_utxos, 3, repeated: true, type: Walletrpc.UtxoLease
end

defmodule Walletrpc.TxTemplate.OutputsEntry do
  @moduledoc false
  use Protobuf, map: true, syntax: :proto3

  @type t :: %__MODULE__{
          key: String.t(),
          value: non_neg_integer
        }

  defstruct [:key, :value]

  field :key, 1, type: :string
  field :value, 2, type: :uint64
end

defmodule Walletrpc.TxTemplate do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          inputs: [Lnrpc.OutPoint.t()],
          outputs: %{String.t() => non_neg_integer}
        }

  defstruct [:inputs, :outputs]

  field :inputs, 1, repeated: true, type: Lnrpc.OutPoint
  field :outputs, 2, repeated: true, type: Walletrpc.TxTemplate.OutputsEntry, map: true
end

defmodule Walletrpc.UtxoLease do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          id: binary,
          outpoint: Lnrpc.OutPoint.t() | nil,
          expiration: non_neg_integer,
          pk_script: binary,
          value: non_neg_integer
        }

  defstruct [:id, :outpoint, :expiration, :pk_script, :value]

  field :id, 1, type: :bytes
  field :outpoint, 2, type: Lnrpc.OutPoint
  field :expiration, 3, type: :uint64
  field :pk_script, 4, type: :bytes
  field :value, 5, type: :uint64
end

defmodule Walletrpc.SignPsbtRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          funded_psbt: binary
        }

  defstruct [:funded_psbt]

  field :funded_psbt, 1, type: :bytes
end

defmodule Walletrpc.SignPsbtResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          signed_psbt: binary
        }

  defstruct [:signed_psbt]

  field :signed_psbt, 1, type: :bytes
end

defmodule Walletrpc.FinalizePsbtRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          funded_psbt: binary,
          account: String.t()
        }

  defstruct [:funded_psbt, :account]

  field :funded_psbt, 1, type: :bytes
  field :account, 5, type: :string
end

defmodule Walletrpc.FinalizePsbtResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          signed_psbt: binary,
          raw_final_tx: binary
        }

  defstruct [:signed_psbt, :raw_final_tx]

  field :signed_psbt, 1, type: :bytes
  field :raw_final_tx, 2, type: :bytes
end

defmodule Walletrpc.ListLeasesRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3
  @type t :: %__MODULE__{}

  defstruct []
end

defmodule Walletrpc.ListLeasesResponse do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          locked_utxos: [Walletrpc.UtxoLease.t()]
        }

  defstruct [:locked_utxos]

  field :locked_utxos, 1, repeated: true, type: Walletrpc.UtxoLease
end

defmodule Walletrpc.WalletKit.Service do
  @moduledoc false
  use GRPC.Service, name: "walletrpc.WalletKit"

  rpc :ListUnspent, Walletrpc.ListUnspentRequest, Walletrpc.ListUnspentResponse

  rpc :LeaseOutput, Walletrpc.LeaseOutputRequest, Walletrpc.LeaseOutputResponse

  rpc :ReleaseOutput, Walletrpc.ReleaseOutputRequest, Walletrpc.ReleaseOutputResponse

  rpc :ListLeases, Walletrpc.ListLeasesRequest, Walletrpc.ListLeasesResponse

  rpc :DeriveNextKey, Walletrpc.KeyReq, Signrpc.KeyDescriptor

  rpc :DeriveKey, Signrpc.KeyLocator, Signrpc.KeyDescriptor

  rpc :NextAddr, Walletrpc.AddrRequest, Walletrpc.AddrResponse

  rpc :ListAccounts, Walletrpc.ListAccountsRequest, Walletrpc.ListAccountsResponse

  rpc :ImportAccount, Walletrpc.ImportAccountRequest, Walletrpc.ImportAccountResponse

  rpc :ImportPublicKey, Walletrpc.ImportPublicKeyRequest, Walletrpc.ImportPublicKeyResponse

  rpc :PublishTransaction, Walletrpc.Transaction, Walletrpc.PublishResponse

  rpc :SendOutputs, Walletrpc.SendOutputsRequest, Walletrpc.SendOutputsResponse

  rpc :EstimateFee, Walletrpc.EstimateFeeRequest, Walletrpc.EstimateFeeResponse

  rpc :PendingSweeps, Walletrpc.PendingSweepsRequest, Walletrpc.PendingSweepsResponse

  rpc :BumpFee, Walletrpc.BumpFeeRequest, Walletrpc.BumpFeeResponse

  rpc :ListSweeps, Walletrpc.ListSweepsRequest, Walletrpc.ListSweepsResponse

  rpc :LabelTransaction, Walletrpc.LabelTransactionRequest, Walletrpc.LabelTransactionResponse

  rpc :FundPsbt, Walletrpc.FundPsbtRequest, Walletrpc.FundPsbtResponse

  rpc :SignPsbt, Walletrpc.SignPsbtRequest, Walletrpc.SignPsbtResponse

  rpc :FinalizePsbt, Walletrpc.FinalizePsbtRequest, Walletrpc.FinalizePsbtResponse
end

defmodule Walletrpc.WalletKit.Stub do
  @moduledoc false
  use GRPC.Stub, service: Walletrpc.WalletKit.Service
end
