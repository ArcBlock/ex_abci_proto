defmodule AbciVendor.KVPair do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          key: String.t(),
          value: String.t()
        }
  defstruct [:key, :value]

  field :key, 1, type: :bytes
  field :value, 2, type: :bytes
end

defmodule AbciVendor.ProofOp do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          type: String.t(),
          key: String.t(),
          data: String.t()
        }
  defstruct [:type, :key, :data]

  field :type, 1, type: :string
  field :key, 2, type: :bytes
  field :data, 3, type: :bytes
end

defmodule AbciVendor.Proof do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          ops: [AbciVendor.ProofOp.t()]
        }
  defstruct [:ops]

  field :ops, 1, repeated: true, type: AbciVendor.ProofOp
end

defmodule AbciVendor.BlockParams do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          max_bytes: integer,
          max_gas: integer
        }
  defstruct [:max_bytes, :max_gas]

  field :max_bytes, 1, type: :int64
  field :max_gas, 2, type: :int64
end

defmodule AbciVendor.EvidenceParams do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          max_age: integer
        }
  defstruct [:max_age]

  field :max_age, 1, type: :int64
end

defmodule AbciVendor.ValidatorParams do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          pub_key_types: [String.t()]
        }
  defstruct [:pub_key_types]

  field :pub_key_types, 1, repeated: true, type: :string
end

defmodule AbciVendor.ConsensusParams do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          block: AbciVendor.BlockParams.t(),
          evidence: AbciVendor.EvidenceParams.t(),
          validator: AbciVendor.ValidatorParams.t()
        }
  defstruct [:block, :evidence, :validator]

  field :block, 1, type: AbciVendor.BlockParams
  field :evidence, 2, type: AbciVendor.EvidenceParams
  field :validator, 3, type: AbciVendor.ValidatorParams
end

defmodule AbciVendor.LastCommitInfo do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          round: integer,
          votes: [AbciVendor.VoteInfo.t()]
        }
  defstruct [:round, :votes]

  field :round, 1, type: :int32
  field :votes, 2, repeated: true, type: AbciVendor.VoteInfo
end

defmodule AbciVendor.Version do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          Block: non_neg_integer,
          App: non_neg_integer
        }
  defstruct [:Block, :App]

  field :Block, 1, type: :uint64
  field :App, 2, type: :uint64
end

defmodule AbciVendor.BlockID do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          hash: String.t(),
          parts_header: AbciVendor.PartSetHeader.t()
        }
  defstruct [:hash, :parts_header]

  field :hash, 1, type: :bytes
  field :parts_header, 2, type: AbciVendor.PartSetHeader
end

defmodule AbciVendor.PartSetHeader do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          total: integer,
          hash: String.t()
        }
  defstruct [:total, :hash]

  field :total, 1, type: :int32
  field :hash, 2, type: :bytes
end

defmodule AbciVendor.Validator do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          address: String.t(),
          power: integer
        }
  defstruct [:address, :power]

  field :address, 1, type: :bytes
  field :power, 3, type: :int64
end

defmodule AbciVendor.ValidatorUpdate do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          pub_key: AbciVendor.PubKey.t(),
          power: integer
        }
  defstruct [:pub_key, :power]

  field :pub_key, 1, type: AbciVendor.PubKey
  field :power, 2, type: :int64
end

defmodule AbciVendor.VoteInfo do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          validator: AbciVendor.Validator.t(),
          signed_last_block: boolean
        }
  defstruct [:validator, :signed_last_block]

  field :validator, 1, type: AbciVendor.Validator
  field :signed_last_block, 2, type: :bool
end

defmodule AbciVendor.PubKey do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          type: String.t(),
          data: String.t()
        }
  defstruct [:type, :data]

  field :type, 1, type: :string
  field :data, 2, type: :bytes
end

defmodule AbciVendor.Evidence do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          type: String.t(),
          validator: AbciVendor.Validator.t(),
          height: integer,
          time: Google.Protobuf.Timestamp.t(),
          total_voting_power: integer
        }
  defstruct [:type, :validator, :height, :time, :total_voting_power]

  field :type, 1, type: :string
  field :validator, 2, type: AbciVendor.Validator
  field :height, 3, type: :int64
  field :time, 4, type: Google.Protobuf.Timestamp
  field :total_voting_power, 5, type: :int64
end

defmodule AbciVendor.Header do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          version: AbciVendor.Version.t(),
          chain_id: String.t(),
          height: integer,
          time: Google.Protobuf.Timestamp.t(),
          num_txs: integer,
          total_txs: integer,
          last_block_id: AbciVendor.BlockID.t(),
          last_commit_hash: String.t(),
          data_hash: String.t(),
          validators_hash: String.t(),
          next_validators_hash: String.t(),
          consensus_hash: String.t(),
          app_hash: String.t(),
          last_results_hash: String.t(),
          evidence_hash: String.t(),
          proposer_address: String.t()
        }
  defstruct [
    :version,
    :chain_id,
    :height,
    :time,
    :num_txs,
    :total_txs,
    :last_block_id,
    :last_commit_hash,
    :data_hash,
    :validators_hash,
    :next_validators_hash,
    :consensus_hash,
    :app_hash,
    :last_results_hash,
    :evidence_hash,
    :proposer_address
  ]

  field :version, 1, type: AbciVendor.Version
  field :chain_id, 2, type: :string
  field :height, 3, type: :int64
  field :time, 4, type: Google.Protobuf.Timestamp
  field :num_txs, 5, type: :int64
  field :total_txs, 6, type: :int64
  field :last_block_id, 7, type: AbciVendor.BlockID
  field :last_commit_hash, 8, type: :bytes
  field :data_hash, 9, type: :bytes
  field :validators_hash, 10, type: :bytes
  field :next_validators_hash, 11, type: :bytes
  field :consensus_hash, 12, type: :bytes
  field :app_hash, 13, type: :bytes
  field :last_results_hash, 14, type: :bytes
  field :evidence_hash, 15, type: :bytes
  field :proposer_address, 16, type: :bytes
end

defmodule AbciVendor.RequestEcho do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          message: String.t()
        }
  defstruct [:message]

  field :message, 1, type: :string
end

defmodule AbciVendor.RequestFlush do
  @moduledoc false
  use Protobuf, syntax: :proto3

  defstruct []
end

defmodule AbciVendor.RequestInfo do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          version: String.t(),
          block_version: non_neg_integer,
          p2p_version: non_neg_integer
        }
  defstruct [:version, :block_version, :p2p_version]

  field :version, 1, type: :string
  field :block_version, 2, type: :uint64
  field :p2p_version, 3, type: :uint64
end

defmodule AbciVendor.RequestSetOption do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          key: String.t(),
          value: String.t()
        }
  defstruct [:key, :value]

  field :key, 1, type: :string
  field :value, 2, type: :string
end

defmodule AbciVendor.RequestInitChain do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          time: Google.Protobuf.Timestamp.t(),
          chain_id: String.t(),
          consensus_params: AbciVendor.ConsensusParams.t(),
          validators: [AbciVendor.ValidatorUpdate.t()],
          app_state_bytes: String.t()
        }
  defstruct [:time, :chain_id, :consensus_params, :validators, :app_state_bytes]

  field :time, 1, type: Google.Protobuf.Timestamp
  field :chain_id, 2, type: :string
  field :consensus_params, 3, type: AbciVendor.ConsensusParams
  field :validators, 4, repeated: true, type: AbciVendor.ValidatorUpdate
  field :app_state_bytes, 5, type: :bytes
end

defmodule AbciVendor.RequestQuery do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          data: String.t(),
          path: String.t(),
          height: integer,
          prove: boolean
        }
  defstruct [:data, :path, :height, :prove]

  field :data, 1, type: :bytes
  field :path, 2, type: :string
  field :height, 3, type: :int64
  field :prove, 4, type: :bool
end

defmodule AbciVendor.RequestBeginBlock do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          hash: String.t(),
          header: AbciVendor.Header.t(),
          last_commit_info: AbciVendor.LastCommitInfo.t(),
          byzantine_validators: [AbciVendor.Evidence.t()]
        }
  defstruct [:hash, :header, :last_commit_info, :byzantine_validators]

  field :hash, 1, type: :bytes
  field :header, 2, type: AbciVendor.Header
  field :last_commit_info, 3, type: AbciVendor.LastCommitInfo
  field :byzantine_validators, 4, repeated: true, type: AbciVendor.Evidence
end

defmodule AbciVendor.RequestCheckTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          tx: String.t()
        }
  defstruct [:tx]

  field :tx, 1, type: :bytes
end

defmodule AbciVendor.RequestDeliverTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          tx: String.t()
        }
  defstruct [:tx]

  field :tx, 1, type: :bytes
end

defmodule AbciVendor.RequestEndBlock do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          height: integer
        }
  defstruct [:height]

  field :height, 1, type: :int64
end

defmodule AbciVendor.RequestCommit do
  @moduledoc false
  use Protobuf, syntax: :proto3

  defstruct []
end

defmodule AbciVendor.Request do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          value: {atom, any}
        }
  defstruct [:value]

  oneof :value, 0
  field :echo, 2, type: AbciVendor.RequestEcho, oneof: 0
  field :flush, 3, type: AbciVendor.RequestFlush, oneof: 0
  field :info, 4, type: AbciVendor.RequestInfo, oneof: 0
  field :set_option, 5, type: AbciVendor.RequestSetOption, oneof: 0
  field :init_chain, 6, type: AbciVendor.RequestInitChain, oneof: 0
  field :query, 7, type: AbciVendor.RequestQuery, oneof: 0
  field :begin_block, 8, type: AbciVendor.RequestBeginBlock, oneof: 0
  field :check_tx, 9, type: AbciVendor.RequestCheckTx, oneof: 0
  field :deliver_tx, 19, type: AbciVendor.RequestDeliverTx, oneof: 0
  field :end_block, 11, type: AbciVendor.RequestEndBlock, oneof: 0
  field :commit, 12, type: AbciVendor.RequestCommit, oneof: 0
end

defmodule AbciVendor.ResponseException do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          error: String.t()
        }
  defstruct [:error]

  field :error, 1, type: :string
end

defmodule AbciVendor.ResponseEcho do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          message: String.t()
        }
  defstruct [:message]

  field :message, 1, type: :string
end

defmodule AbciVendor.ResponseFlush do
  @moduledoc false
  use Protobuf, syntax: :proto3

  defstruct []
end

defmodule AbciVendor.ResponseInfo do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          data: String.t(),
          version: String.t(),
          app_version: non_neg_integer,
          last_block_height: integer,
          last_block_app_hash: String.t()
        }
  defstruct [:data, :version, :app_version, :last_block_height, :last_block_app_hash]

  field :data, 1, type: :string
  field :version, 2, type: :string
  field :app_version, 3, type: :uint64
  field :last_block_height, 4, type: :int64
  field :last_block_app_hash, 5, type: :bytes
end

defmodule AbciVendor.ResponseSetOption do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: non_neg_integer,
          log: String.t(),
          info: String.t()
        }
  defstruct [:code, :log, :info]

  field :code, 1, type: :uint32
  field :log, 3, type: :string
  field :info, 4, type: :string
end

defmodule AbciVendor.ResponseInitChain do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          consensus_params: AbciVendor.ConsensusParams.t(),
          validators: [AbciVendor.ValidatorUpdate.t()]
        }
  defstruct [:consensus_params, :validators]

  field :consensus_params, 1, type: AbciVendor.ConsensusParams
  field :validators, 2, repeated: true, type: AbciVendor.ValidatorUpdate
end

defmodule AbciVendor.ResponseQuery do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: non_neg_integer,
          log: String.t(),
          info: String.t(),
          index: integer,
          key: String.t(),
          value: String.t(),
          proof: AbciVendor.Proof.t(),
          height: integer,
          codespace: String.t()
        }
  defstruct [:code, :log, :info, :index, :key, :value, :proof, :height, :codespace]

  field :code, 1, type: :uint32
  field :log, 3, type: :string
  field :info, 4, type: :string
  field :index, 5, type: :int64
  field :key, 6, type: :bytes
  field :value, 7, type: :bytes
  field :proof, 8, type: AbciVendor.Proof
  field :height, 9, type: :int64
  field :codespace, 10, type: :string
end

defmodule AbciVendor.ResponseBeginBlock do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          tags: [AbciVendor.KVPair.t()]
        }
  defstruct [:tags]

  field :tags, 1, repeated: true, type: AbciVendor.KVPair
end

defmodule AbciVendor.ResponseCheckTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: non_neg_integer,
          data: String.t(),
          log: String.t(),
          info: String.t(),
          gas_wanted: integer,
          gas_used: integer,
          tags: [AbciVendor.KVPair.t()],
          codespace: String.t()
        }
  defstruct [:code, :data, :log, :info, :gas_wanted, :gas_used, :tags, :codespace]

  field :code, 1, type: :uint32
  field :data, 2, type: :bytes
  field :log, 3, type: :string
  field :info, 4, type: :string
  field :gas_wanted, 5, type: :int64
  field :gas_used, 6, type: :int64
  field :tags, 7, repeated: true, type: AbciVendor.KVPair
  field :codespace, 8, type: :string
end

defmodule AbciVendor.ResponseDeliverTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          code: non_neg_integer,
          data: String.t(),
          log: String.t(),
          info: String.t(),
          gas_wanted: integer,
          gas_used: integer,
          tags: [AbciVendor.KVPair.t()],
          codespace: String.t()
        }
  defstruct [:code, :data, :log, :info, :gas_wanted, :gas_used, :tags, :codespace]

  field :code, 1, type: :uint32
  field :data, 2, type: :bytes
  field :log, 3, type: :string
  field :info, 4, type: :string
  field :gas_wanted, 5, type: :int64
  field :gas_used, 6, type: :int64
  field :tags, 7, repeated: true, type: AbciVendor.KVPair
  field :codespace, 8, type: :string
end

defmodule AbciVendor.ResponseEndBlock do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          validator_updates: [AbciVendor.ValidatorUpdate.t()],
          consensus_param_updates: AbciVendor.ConsensusParams.t(),
          tags: [AbciVendor.KVPair.t()]
        }
  defstruct [:validator_updates, :consensus_param_updates, :tags]

  field :validator_updates, 1, repeated: true, type: AbciVendor.ValidatorUpdate
  field :consensus_param_updates, 2, type: AbciVendor.ConsensusParams
  field :tags, 3, repeated: true, type: AbciVendor.KVPair
end

defmodule AbciVendor.ResponseCommit do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          data: String.t()
        }
  defstruct [:data]

  field :data, 2, type: :bytes
end

defmodule AbciVendor.Response do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          value: {atom, any}
        }
  defstruct [:value]

  oneof :value, 0
  field :exception, 1, type: AbciVendor.ResponseException, oneof: 0
  field :echo, 2, type: AbciVendor.ResponseEcho, oneof: 0
  field :flush, 3, type: AbciVendor.ResponseFlush, oneof: 0
  field :info, 4, type: AbciVendor.ResponseInfo, oneof: 0
  field :set_option, 5, type: AbciVendor.ResponseSetOption, oneof: 0
  field :init_chain, 6, type: AbciVendor.ResponseInitChain, oneof: 0
  field :query, 7, type: AbciVendor.ResponseQuery, oneof: 0
  field :begin_block, 8, type: AbciVendor.ResponseBeginBlock, oneof: 0
  field :check_tx, 9, type: AbciVendor.ResponseCheckTx, oneof: 0
  field :deliver_tx, 10, type: AbciVendor.ResponseDeliverTx, oneof: 0
  field :end_block, 11, type: AbciVendor.ResponseEndBlock, oneof: 0
  field :commit, 12, type: AbciVendor.ResponseCommit, oneof: 0
end

defmodule AbciVendor.RequestPing do
  @moduledoc false
  use Protobuf, syntax: :proto3

  defstruct []
end

defmodule AbciVendor.RequestBroadcastTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          tx: String.t()
        }
  defstruct [:tx]

  field :tx, 1, type: :bytes
end

defmodule AbciVendor.ResponsePing do
  @moduledoc false
  use Protobuf, syntax: :proto3

  defstruct []
end

defmodule AbciVendor.ResponseBroadcastTx do
  @moduledoc false
  use Protobuf, syntax: :proto3

  @type t :: %__MODULE__{
          check_tx: AbciVendor.ResponseCheckTx.t(),
          deliver_tx: AbciVendor.ResponseDeliverTx.t()
        }
  defstruct [:check_tx, :deliver_tx]

  field :check_tx, 1, type: AbciVendor.ResponseCheckTx
  field :deliver_tx, 2, type: AbciVendor.ResponseDeliverTx
end

defmodule AbciVendor.ABCIApplication.Service do
  @moduledoc false
  use GRPC.Service, name: "abci_vendor.ABCIApplication"

  rpc :Echo, AbciVendor.RequestEcho, AbciVendor.ResponseEcho
  rpc :Flush, AbciVendor.RequestFlush, AbciVendor.ResponseFlush
  rpc :Info, AbciVendor.RequestInfo, AbciVendor.ResponseInfo
  rpc :SetOption, AbciVendor.RequestSetOption, AbciVendor.ResponseSetOption
  rpc :DeliverTx, AbciVendor.RequestDeliverTx, AbciVendor.ResponseDeliverTx
  rpc :CheckTx, AbciVendor.RequestCheckTx, AbciVendor.ResponseCheckTx
  rpc :Query, AbciVendor.RequestQuery, AbciVendor.ResponseQuery
  rpc :Commit, AbciVendor.RequestCommit, AbciVendor.ResponseCommit
  rpc :InitChain, AbciVendor.RequestInitChain, AbciVendor.ResponseInitChain
  rpc :BeginBlock, AbciVendor.RequestBeginBlock, AbciVendor.ResponseBeginBlock
  rpc :EndBlock, AbciVendor.RequestEndBlock, AbciVendor.ResponseEndBlock
end

defmodule AbciVendor.ABCIApplication.Stub do
  @moduledoc false
  use GRPC.Stub, service: AbciVendor.ABCIApplication.Service
end
