defmodule Walletrpc.AddressType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "walletrpc.AddressType",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :UNKNOWN, 0
  field :WITNESS_PUBKEY_HASH, 1
  field :NESTED_WITNESS_PUBKEY_HASH, 2
  field :HYBRID_NESTED_WITNESS_PUBKEY_HASH, 3
  field :TAPROOT_PUBKEY, 4
end

defmodule Walletrpc.WitnessType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "walletrpc.WitnessType",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

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
  field :COMMITMENT_NO_DELAY_TWEAKLESS, 14
  field :COMMITMENT_TO_REMOTE_CONFIRMED, 15
  field :HTLC_OFFERED_TIMEOUT_SECOND_LEVEL_INPUT_CONFIRMED, 16
  field :HTLC_ACCEPTED_SUCCESS_SECOND_LEVEL_INPUT_CONFIRMED, 17
  field :LEASE_COMMITMENT_TIME_LOCK, 18
  field :LEASE_COMMITMENT_TO_REMOTE_CONFIRMED, 19
  field :LEASE_HTLC_OFFERED_TIMEOUT_SECOND_LEVEL, 20
  field :LEASE_HTLC_ACCEPTED_SUCCESS_SECOND_LEVEL, 21
  field :TAPROOT_PUB_KEY_SPEND, 22
  field :TAPROOT_LOCAL_COMMIT_SPEND, 23
  field :TAPROOT_REMOTE_COMMIT_SPEND, 24
  field :TAPROOT_ANCHOR_SWEEP_SPEND, 25
  field :TAPROOT_HTLC_OFFERED_TIMEOUT_SECOND_LEVEL, 26
  field :TAPROOT_HTLC_ACCEPTED_SUCCESS_SECOND_LEVEL, 27
  field :TAPROOT_HTLC_SECOND_LEVEL_REVOKE, 28
  field :TAPROOT_HTLC_ACCEPTED_REVOKE, 29
  field :TAPROOT_HTLC_OFFERED_REVOKE, 30
  field :TAPROOT_HTLC_OFFERED_REMOTE_TIMEOUT, 31
  field :TAPROOT_HTLC_LOCAL_OFFERED_TIMEOUT, 32
  field :TAPROOT_HTLC_ACCEPTED_REMOTE_SUCCESS, 33
  field :TAPROOT_HTLC_ACCEPTED_LOCAL_SUCCESS, 34
  field :TAPROOT_COMMITMENT_REVOKE, 35
end

defmodule Walletrpc.ChangeAddressType do
  @moduledoc false

  use Protobuf,
    enum: true,
    full_name: "walletrpc.ChangeAddressType",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :CHANGE_ADDRESS_TYPE_UNSPECIFIED, 0
  field :CHANGE_ADDRESS_TYPE_P2TR, 1
end

defmodule Walletrpc.ListUnspentRequest do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.ListUnspentRequest",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :min_confs, 1, type: :int32, json_name: "minConfs"
  field :max_confs, 2, type: :int32, json_name: "maxConfs"
  field :account, 3, type: :string
  field :unconfirmed_only, 4, type: :bool, json_name: "unconfirmedOnly"
end

defmodule Walletrpc.ListUnspentResponse do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.ListUnspentResponse",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :utxos, 1, repeated: true, type: Lnrpc.Utxo
end

defmodule Walletrpc.LeaseOutputRequest do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.LeaseOutputRequest",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :id, 1, type: :bytes
  field :outpoint, 2, type: Lnrpc.OutPoint
  field :expiration_seconds, 3, type: :uint64, json_name: "expirationSeconds"
end

defmodule Walletrpc.LeaseOutputResponse do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.LeaseOutputResponse",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :expiration, 1, type: :uint64
end

defmodule Walletrpc.ReleaseOutputRequest do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.ReleaseOutputRequest",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :id, 1, type: :bytes
  field :outpoint, 2, type: Lnrpc.OutPoint
end

defmodule Walletrpc.ReleaseOutputResponse do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.ReleaseOutputResponse",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3
end

defmodule Walletrpc.KeyReq do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.KeyReq",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :key_finger_print, 1, type: :int32, json_name: "keyFingerPrint"
  field :key_family, 2, type: :int32, json_name: "keyFamily"
end

defmodule Walletrpc.AddrRequest do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.AddrRequest",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :account, 1, type: :string
  field :type, 2, type: Walletrpc.AddressType, enum: true
  field :change, 3, type: :bool
end

defmodule Walletrpc.AddrResponse do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.AddrResponse",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :addr, 1, type: :string
end

defmodule Walletrpc.Account do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.Account",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :name, 1, type: :string
  field :address_type, 2, type: Walletrpc.AddressType, json_name: "addressType", enum: true
  field :extended_public_key, 3, type: :string, json_name: "extendedPublicKey"
  field :master_key_fingerprint, 4, type: :bytes, json_name: "masterKeyFingerprint"
  field :derivation_path, 5, type: :string, json_name: "derivationPath"
  field :external_key_count, 6, type: :uint32, json_name: "externalKeyCount"
  field :internal_key_count, 7, type: :uint32, json_name: "internalKeyCount"
  field :watch_only, 8, type: :bool, json_name: "watchOnly"
end

defmodule Walletrpc.AddressProperty do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.AddressProperty",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :address, 1, type: :string
  field :is_internal, 2, type: :bool, json_name: "isInternal"
  field :balance, 3, type: :int64
  field :derivation_path, 4, type: :string, json_name: "derivationPath"
  field :public_key, 5, type: :bytes, json_name: "publicKey"
end

defmodule Walletrpc.AccountWithAddresses do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.AccountWithAddresses",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :name, 1, type: :string
  field :address_type, 2, type: Walletrpc.AddressType, json_name: "addressType", enum: true
  field :derivation_path, 3, type: :string, json_name: "derivationPath"
  field :addresses, 4, repeated: true, type: Walletrpc.AddressProperty
end

defmodule Walletrpc.ListAccountsRequest do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.ListAccountsRequest",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :name, 1, type: :string
  field :address_type, 2, type: Walletrpc.AddressType, json_name: "addressType", enum: true
end

defmodule Walletrpc.ListAccountsResponse do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.ListAccountsResponse",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :accounts, 1, repeated: true, type: Walletrpc.Account
end

defmodule Walletrpc.RequiredReserveRequest do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.RequiredReserveRequest",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :additional_public_channels, 1, type: :uint32, json_name: "additionalPublicChannels"
end

defmodule Walletrpc.RequiredReserveResponse do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.RequiredReserveResponse",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :required_reserve, 1, type: :int64, json_name: "requiredReserve"
end

defmodule Walletrpc.ListAddressesRequest do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.ListAddressesRequest",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :account_name, 1, type: :string, json_name: "accountName"
  field :show_custom_accounts, 2, type: :bool, json_name: "showCustomAccounts"
end

defmodule Walletrpc.ListAddressesResponse do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.ListAddressesResponse",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :account_with_addresses, 1,
    repeated: true,
    type: Walletrpc.AccountWithAddresses,
    json_name: "accountWithAddresses"
end

defmodule Walletrpc.GetTransactionRequest do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.GetTransactionRequest",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :txid, 1, type: :string
end

defmodule Walletrpc.SignMessageWithAddrRequest do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.SignMessageWithAddrRequest",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :msg, 1, type: :bytes
  field :addr, 2, type: :string
end

defmodule Walletrpc.SignMessageWithAddrResponse do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.SignMessageWithAddrResponse",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :signature, 1, type: :string
end

defmodule Walletrpc.VerifyMessageWithAddrRequest do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.VerifyMessageWithAddrRequest",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :msg, 1, type: :bytes
  field :signature, 2, type: :string
  field :addr, 3, type: :string
end

defmodule Walletrpc.VerifyMessageWithAddrResponse do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.VerifyMessageWithAddrResponse",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :valid, 1, type: :bool
  field :pubkey, 2, type: :bytes
end

defmodule Walletrpc.ImportAccountRequest do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.ImportAccountRequest",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :name, 1, type: :string
  field :extended_public_key, 2, type: :string, json_name: "extendedPublicKey"
  field :master_key_fingerprint, 3, type: :bytes, json_name: "masterKeyFingerprint"
  field :address_type, 4, type: Walletrpc.AddressType, json_name: "addressType", enum: true
  field :dry_run, 5, type: :bool, json_name: "dryRun"
end

defmodule Walletrpc.ImportAccountResponse do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.ImportAccountResponse",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :account, 1, type: Walletrpc.Account

  field :dry_run_external_addrs, 2,
    repeated: true,
    type: :string,
    json_name: "dryRunExternalAddrs"

  field :dry_run_internal_addrs, 3,
    repeated: true,
    type: :string,
    json_name: "dryRunInternalAddrs"
end

defmodule Walletrpc.ImportPublicKeyRequest do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.ImportPublicKeyRequest",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :public_key, 1, type: :bytes, json_name: "publicKey"
  field :address_type, 2, type: Walletrpc.AddressType, json_name: "addressType", enum: true
end

defmodule Walletrpc.ImportPublicKeyResponse do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.ImportPublicKeyResponse",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3
end

defmodule Walletrpc.ImportTapscriptRequest do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.ImportTapscriptRequest",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  oneof :script, 0

  field :internal_public_key, 1, type: :bytes, json_name: "internalPublicKey"
  field :full_tree, 2, type: Walletrpc.TapscriptFullTree, json_name: "fullTree", oneof: 0

  field :partial_reveal, 3,
    type: Walletrpc.TapscriptPartialReveal,
    json_name: "partialReveal",
    oneof: 0

  field :root_hash_only, 4, type: :bytes, json_name: "rootHashOnly", oneof: 0
  field :full_key_only, 5, type: :bool, json_name: "fullKeyOnly", oneof: 0
end

defmodule Walletrpc.TapscriptFullTree do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.TapscriptFullTree",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :all_leaves, 1, repeated: true, type: Walletrpc.TapLeaf, json_name: "allLeaves"
end

defmodule Walletrpc.TapLeaf do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.TapLeaf",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :leaf_version, 1, type: :uint32, json_name: "leafVersion"
  field :script, 2, type: :bytes
end

defmodule Walletrpc.TapscriptPartialReveal do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.TapscriptPartialReveal",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :revealed_leaf, 1, type: Walletrpc.TapLeaf, json_name: "revealedLeaf"
  field :full_inclusion_proof, 2, type: :bytes, json_name: "fullInclusionProof"
end

defmodule Walletrpc.ImportTapscriptResponse do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.ImportTapscriptResponse",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :p2tr_address, 1, type: :string, json_name: "p2trAddress"
end

defmodule Walletrpc.Transaction do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.Transaction",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :tx_hex, 1, type: :bytes, json_name: "txHex"
  field :label, 2, type: :string
end

defmodule Walletrpc.PublishResponse do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.PublishResponse",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :publish_error, 1, type: :string, json_name: "publishError"
end

defmodule Walletrpc.RemoveTransactionResponse do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.RemoveTransactionResponse",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :status, 1, type: :string
end

defmodule Walletrpc.SendOutputsRequest do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.SendOutputsRequest",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :sat_per_kw, 1, type: :int64, json_name: "satPerKw"
  field :outputs, 2, repeated: true, type: Signrpc.TxOut
  field :label, 3, type: :string
  field :min_confs, 4, type: :int32, json_name: "minConfs"
  field :spend_unconfirmed, 5, type: :bool, json_name: "spendUnconfirmed"

  field :coin_selection_strategy, 6,
    type: Lnrpc.CoinSelectionStrategy,
    json_name: "coinSelectionStrategy",
    enum: true
end

defmodule Walletrpc.SendOutputsResponse do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.SendOutputsResponse",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :raw_tx, 1, type: :bytes, json_name: "rawTx"
end

defmodule Walletrpc.EstimateFeeRequest do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.EstimateFeeRequest",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :conf_target, 1, type: :int32, json_name: "confTarget"
end

defmodule Walletrpc.EstimateFeeResponse do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.EstimateFeeResponse",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :sat_per_kw, 1, type: :int64, json_name: "satPerKw"
end

defmodule Walletrpc.PendingSweep do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.PendingSweep",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :outpoint, 1, type: Lnrpc.OutPoint
  field :witness_type, 2, type: Walletrpc.WitnessType, json_name: "witnessType", enum: true
  field :amount_sat, 3, type: :uint32, json_name: "amountSat"
  field :sat_per_byte, 4, type: :uint32, json_name: "satPerByte", deprecated: true
  field :broadcast_attempts, 5, type: :uint32, json_name: "broadcastAttempts"

  field :next_broadcast_height, 6,
    type: :uint32,
    json_name: "nextBroadcastHeight",
    deprecated: true

  field :force, 7, type: :bool, deprecated: true

  field :requested_conf_target, 8,
    type: :uint32,
    json_name: "requestedConfTarget",
    deprecated: true

  field :requested_sat_per_byte, 9,
    type: :uint32,
    json_name: "requestedSatPerByte",
    deprecated: true

  field :sat_per_vbyte, 10, type: :uint64, json_name: "satPerVbyte"
  field :requested_sat_per_vbyte, 11, type: :uint64, json_name: "requestedSatPerVbyte"
  field :immediate, 12, type: :bool
  field :budget, 13, type: :uint64
  field :deadline_height, 14, type: :uint32, json_name: "deadlineHeight"
end

defmodule Walletrpc.PendingSweepsRequest do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.PendingSweepsRequest",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3
end

defmodule Walletrpc.PendingSweepsResponse do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.PendingSweepsResponse",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :pending_sweeps, 1,
    repeated: true,
    type: Walletrpc.PendingSweep,
    json_name: "pendingSweeps"
end

defmodule Walletrpc.BumpFeeRequest do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.BumpFeeRequest",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :outpoint, 1, type: Lnrpc.OutPoint
  field :target_conf, 2, type: :uint32, json_name: "targetConf"
  field :sat_per_byte, 3, type: :uint32, json_name: "satPerByte", deprecated: true
  field :force, 4, type: :bool, deprecated: true
  field :sat_per_vbyte, 5, type: :uint64, json_name: "satPerVbyte"
  field :immediate, 6, type: :bool
  field :budget, 7, type: :uint64
end

defmodule Walletrpc.BumpFeeResponse do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.BumpFeeResponse",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :status, 1, type: :string
end

defmodule Walletrpc.ListSweepsRequest do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.ListSweepsRequest",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :verbose, 1, type: :bool
  field :start_height, 2, type: :int32, json_name: "startHeight"
end

defmodule Walletrpc.ListSweepsResponse.TransactionIDs do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.ListSweepsResponse.TransactionIDs",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :transaction_ids, 1, repeated: true, type: :string, json_name: "transactionIds"
end

defmodule Walletrpc.ListSweepsResponse do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.ListSweepsResponse",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  oneof :sweeps, 0

  field :transaction_details, 1,
    type: Lnrpc.TransactionDetails,
    json_name: "transactionDetails",
    oneof: 0

  field :transaction_ids, 2,
    type: Walletrpc.ListSweepsResponse.TransactionIDs,
    json_name: "transactionIds",
    oneof: 0
end

defmodule Walletrpc.LabelTransactionRequest do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.LabelTransactionRequest",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :txid, 1, type: :bytes
  field :label, 2, type: :string
  field :overwrite, 3, type: :bool
end

defmodule Walletrpc.LabelTransactionResponse do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.LabelTransactionResponse",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3
end

defmodule Walletrpc.FundPsbtRequest do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.FundPsbtRequest",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  oneof :template, 0

  oneof :fees, 1

  field :psbt, 1, type: :bytes, oneof: 0
  field :raw, 2, type: Walletrpc.TxTemplate, oneof: 0
  field :coin_select, 9, type: Walletrpc.PsbtCoinSelect, json_name: "coinSelect", oneof: 0
  field :target_conf, 3, type: :uint32, json_name: "targetConf", oneof: 1
  field :sat_per_vbyte, 4, type: :uint64, json_name: "satPerVbyte", oneof: 1
  field :account, 5, type: :string
  field :min_confs, 6, type: :int32, json_name: "minConfs"
  field :spend_unconfirmed, 7, type: :bool, json_name: "spendUnconfirmed"
  field :change_type, 8, type: Walletrpc.ChangeAddressType, json_name: "changeType", enum: true

  field :coin_selection_strategy, 10,
    type: Lnrpc.CoinSelectionStrategy,
    json_name: "coinSelectionStrategy",
    enum: true
end

defmodule Walletrpc.FundPsbtResponse do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.FundPsbtResponse",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :funded_psbt, 1, type: :bytes, json_name: "fundedPsbt"
  field :change_output_index, 2, type: :int32, json_name: "changeOutputIndex"
  field :locked_utxos, 3, repeated: true, type: Walletrpc.UtxoLease, json_name: "lockedUtxos"
end

defmodule Walletrpc.TxTemplate.OutputsEntry do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.TxTemplate.OutputsEntry",
    map: true,
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :key, 1, type: :string
  field :value, 2, type: :uint64
end

defmodule Walletrpc.TxTemplate do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.TxTemplate",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :inputs, 1, repeated: true, type: Lnrpc.OutPoint
  field :outputs, 2, repeated: true, type: Walletrpc.TxTemplate.OutputsEntry, map: true
end

defmodule Walletrpc.PsbtCoinSelect do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.PsbtCoinSelect",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  oneof :change_output, 0

  field :psbt, 1, type: :bytes
  field :existing_output_index, 2, type: :int32, json_name: "existingOutputIndex", oneof: 0
  field :add, 3, type: :bool, oneof: 0
end

defmodule Walletrpc.UtxoLease do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.UtxoLease",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :id, 1, type: :bytes
  field :outpoint, 2, type: Lnrpc.OutPoint
  field :expiration, 3, type: :uint64
  field :pk_script, 4, type: :bytes, json_name: "pkScript"
  field :value, 5, type: :uint64
end

defmodule Walletrpc.SignPsbtRequest do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.SignPsbtRequest",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :funded_psbt, 1, type: :bytes, json_name: "fundedPsbt"
end

defmodule Walletrpc.SignPsbtResponse do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.SignPsbtResponse",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :signed_psbt, 1, type: :bytes, json_name: "signedPsbt"
  field :signed_inputs, 2, repeated: true, type: :uint32, json_name: "signedInputs"
end

defmodule Walletrpc.FinalizePsbtRequest do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.FinalizePsbtRequest",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :funded_psbt, 1, type: :bytes, json_name: "fundedPsbt"
  field :account, 5, type: :string
end

defmodule Walletrpc.FinalizePsbtResponse do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.FinalizePsbtResponse",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :signed_psbt, 1, type: :bytes, json_name: "signedPsbt"
  field :raw_final_tx, 2, type: :bytes, json_name: "rawFinalTx"
end

defmodule Walletrpc.ListLeasesRequest do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.ListLeasesRequest",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3
end

defmodule Walletrpc.ListLeasesResponse do
  @moduledoc false

  use Protobuf,
    full_name: "walletrpc.ListLeasesResponse",
    protoc_gen_elixir_version: "0.17.1",
    syntax: :proto3

  field :locked_utxos, 1, repeated: true, type: Walletrpc.UtxoLease, json_name: "lockedUtxos"
end

defmodule Walletrpc.WalletKit.Service do
  @moduledoc false

  use GRPC.Service, name: "walletrpc.WalletKit", protoc_gen_elixir_version: "0.17.1"

  rpc :ListUnspent, Walletrpc.ListUnspentRequest, Walletrpc.ListUnspentResponse

  rpc :LeaseOutput, Walletrpc.LeaseOutputRequest, Walletrpc.LeaseOutputResponse

  rpc :ReleaseOutput, Walletrpc.ReleaseOutputRequest, Walletrpc.ReleaseOutputResponse

  rpc :ListLeases, Walletrpc.ListLeasesRequest, Walletrpc.ListLeasesResponse

  rpc :DeriveNextKey, Walletrpc.KeyReq, Signrpc.KeyDescriptor

  rpc :DeriveKey, Signrpc.KeyLocator, Signrpc.KeyDescriptor

  rpc :NextAddr, Walletrpc.AddrRequest, Walletrpc.AddrResponse

  rpc :GetTransaction, Walletrpc.GetTransactionRequest, Lnrpc.Transaction

  rpc :ListAccounts, Walletrpc.ListAccountsRequest, Walletrpc.ListAccountsResponse

  rpc :RequiredReserve, Walletrpc.RequiredReserveRequest, Walletrpc.RequiredReserveResponse

  rpc :ListAddresses, Walletrpc.ListAddressesRequest, Walletrpc.ListAddressesResponse

  rpc :SignMessageWithAddr,
      Walletrpc.SignMessageWithAddrRequest,
      Walletrpc.SignMessageWithAddrResponse

  rpc :VerifyMessageWithAddr,
      Walletrpc.VerifyMessageWithAddrRequest,
      Walletrpc.VerifyMessageWithAddrResponse

  rpc :ImportAccount, Walletrpc.ImportAccountRequest, Walletrpc.ImportAccountResponse

  rpc :ImportPublicKey, Walletrpc.ImportPublicKeyRequest, Walletrpc.ImportPublicKeyResponse

  rpc :ImportTapscript, Walletrpc.ImportTapscriptRequest, Walletrpc.ImportTapscriptResponse

  rpc :PublishTransaction, Walletrpc.Transaction, Walletrpc.PublishResponse

  rpc :RemoveTransaction, Walletrpc.GetTransactionRequest, Walletrpc.RemoveTransactionResponse

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
