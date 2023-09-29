defmodule Modbus.ReadRequest do
  defstruct transaction_id: 0, unit_id: 0, addr: 0, register_count: 0

  @protocol_id 0
  @function_code 3

  def new(transaction_id, unit_id, addr, register_count) do
    %Modbus.ReadRequest{
      transaction_id: transaction_id,
      unit_id: unit_id,
      addr: addr,
      register_count: register_count
    }
  end

  def to_bytes(request = %Modbus.ReadRequest{}) do
    <<
      request.transaction_id::16,
      @protocol_id::16,
      # remaining byte length
      6::16,
      request.unit_id::8,
      @function_code::8,
      request.addr::16,
      request.register_count::16
    >>
  end
end
