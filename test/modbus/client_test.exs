defmodule Modbus.ClientTest do
  require Logger
  use ExUnit.Case, async: false

  @test_response <<0, 0, 0, 0, 0, 0, 0, 3, 0>>

  setup do
    spawn(fn ->
      {:ok, listen_socket} = :gen_tcp.listen(8080, [:binary, active: false, reuseaddr: true])
      {:ok, socket} = :gen_tcp.accept(listen_socket)
      {:ok, _} = :gen_tcp.recv(socket, 0)
      :ok = :gen_tcp.send(socket, @test_response)
      :ok = :gen_tcp.close(socket)
    end)

    :ok
  end

  test "read" do
    {:ok, socket} = Modbus.Client.connect("127.0.0.1", 8080, 5000)
    request = Modbus.ReadRequest.new(0, 0, 0, 0)
    {:ok, response} = Modbus.Client.read(socket, request, 5000)
    assert response == @test_response
    :ok = Modbus.Client.close(socket)
  end
end
