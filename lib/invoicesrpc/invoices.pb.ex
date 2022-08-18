defmodule Invoicesrpc.LookupModifier do
  @moduledoc false
  use Protobuf, enum: true, syntax: :proto3
  @type t :: integer | :DEFAULT | :HTLC_SET_ONLY | :HTLC_SET_BLANK

  field :DEFAULT, 0

  field :HTLC_SET_ONLY, 1

  field :HTLC_SET_BLANK, 2
end

defmodule Invoicesrpc.CancelInvoiceMsg do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          payment_hash: binary
        }

  defstruct [:payment_hash]

  field :payment_hash, 1, type: :bytes
end

defmodule Invoicesrpc.CancelInvoiceResp do
  @moduledoc false
  use Protobuf, syntax: :proto3
  @type t :: %__MODULE__{}

  defstruct []
end

defmodule Invoicesrpc.AddHoldInvoiceRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          memo: String.t(),
          hash: binary,
          value: integer,
          value_msat: integer,
          description_hash: binary,
          expiry: integer,
          fallback_addr: String.t(),
          cltv_expiry: non_neg_integer,
          route_hints: [Lnrpc.RouteHint.t()],
          private: boolean
        }

  defstruct [
    :memo,
    :hash,
    :value,
    :value_msat,
    :description_hash,
    :expiry,
    :fallback_addr,
    :cltv_expiry,
    :route_hints,
    :private
  ]

  field :memo, 1, type: :string
  field :hash, 2, type: :bytes
  field :value, 3, type: :int64
  field :value_msat, 10, type: :int64
  field :description_hash, 4, type: :bytes
  field :expiry, 5, type: :int64
  field :fallback_addr, 6, type: :string
  field :cltv_expiry, 7, type: :uint64
  field :route_hints, 8, repeated: true, type: Lnrpc.RouteHint
  field :private, 9, type: :bool
end

defmodule Invoicesrpc.AddHoldInvoiceResp do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          payment_request: String.t(),
          add_index: non_neg_integer,
          payment_addr: binary
        }

  defstruct [:payment_request, :add_index, :payment_addr]

  field :payment_request, 1, type: :string
  field :add_index, 2, type: :uint64
  field :payment_addr, 3, type: :bytes
end

defmodule Invoicesrpc.SettleInvoiceMsg do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          preimage: binary
        }

  defstruct [:preimage]

  field :preimage, 1, type: :bytes
end

defmodule Invoicesrpc.SettleInvoiceResp do
  @moduledoc false
  use Protobuf, syntax: :proto3
  @type t :: %__MODULE__{}

  defstruct []
end

defmodule Invoicesrpc.SubscribeSingleInvoiceRequest do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          r_hash: binary
        }

  defstruct [:r_hash]

  field :r_hash, 2, type: :bytes
end

defmodule Invoicesrpc.LookupInvoiceMsg do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          invoice_ref: {atom, any},
          lookup_modifier: Invoicesrpc.LookupModifier.t()
        }

  defstruct [:invoice_ref, :lookup_modifier]

  oneof :invoice_ref, 0
  field :payment_hash, 1, type: :bytes, oneof: 0
  field :payment_addr, 2, type: :bytes, oneof: 0
  field :set_id, 3, type: :bytes, oneof: 0
  field :lookup_modifier, 4, type: Invoicesrpc.LookupModifier, enum: true
end

defmodule Invoicesrpc.Invoices.Service do
  @moduledoc false
  use GRPC.Service, name: "invoicesrpc.Invoices"

  rpc :SubscribeSingleInvoice, Invoicesrpc.SubscribeSingleInvoiceRequest, stream(Lnrpc.Invoice)

  rpc :CancelInvoice, Invoicesrpc.CancelInvoiceMsg, Invoicesrpc.CancelInvoiceResp

  rpc :AddHoldInvoice, Invoicesrpc.AddHoldInvoiceRequest, Invoicesrpc.AddHoldInvoiceResp

  rpc :SettleInvoice, Invoicesrpc.SettleInvoiceMsg, Invoicesrpc.SettleInvoiceResp

  rpc :LookupInvoiceV2, Invoicesrpc.LookupInvoiceMsg, Lnrpc.Invoice
end

defmodule Invoicesrpc.Invoices.Stub do
  @moduledoc false
  use GRPC.Stub, service: Invoicesrpc.Invoices.Service
end
