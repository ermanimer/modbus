defmodule Modbus.ReadRequestTest do
  use ExUnit.Case

  test "to_bytes" do
    request = Modbus.ReadRequest.new(1, 2, 4, 5)
    assert Modbus.ReadRequest.to_bytes(request) == <<0, 1, 0, 0, 0, 6, 2, 3, 0, 4, 0, 5>>
  end
end
