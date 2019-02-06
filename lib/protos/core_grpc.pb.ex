defmodule CoreGrpc.BroadcastAPI.Service do
  @moduledoc false
  use GRPC.Service, name: "core_grpc.BroadcastAPI"

  rpc(:Ping, AbciVendor.RequestPing, AbciVendor.ResponsePing)
  rpc(:BroadcastTx, AbciVendor.RequestBroadcastTx, AbciVendor.ResponseBroadcastTx)
end

defmodule CoreGrpc.BroadcastAPI.Stub do
  @moduledoc false
  use GRPC.Stub, service: CoreGrpc.BroadcastAPI.Service
end
