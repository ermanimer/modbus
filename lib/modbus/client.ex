defmodule Modbus.Client do
  def connect(addr, port, timeout) do
    addr_chars = String.to_charlist(addr)
    :gen_tcp.connect(addr_chars, port, [:binary, active: false, reuseaddr: true], timeout)
  end

  def read(socket, request, timeout) do
    request_bytes = Modbus.ReadRequest.to_bytes(request)

    socket
    |> send_request(request_bytes)
    |> receive_response(timeout)
    |> handle_response()
  end

  def close(socket) do
    :gen_tcp.close(socket)
  end

  defp send_request(socket, request) do
    {:gen_tcp.send(socket, request), socket}
  end

  defp receive_response({:ok, socket}, timeout) do
    :gen_tcp.recv(socket, 0, timeout)
  end

  defp receive_response({{:error, reason}, _}, _), do: {:error, reason}

  defp handle_response({:ok, response}) do
    case {err_code, exc_code} = extract_read_err_codes(response) do
      {3, _} ->
        {:ok, response}

      _ ->
        {:error, %{:err_code => err_code, :exc_code => exc_code}}
    end
  end

  defp handle_response({:error, reason}), do: {:error, reason}

  defp extract_read_err_codes(response) do
    <<_::7*8, err_code::8, exc_code::8, _::binary>> = response
    {err_code, exc_code}
  end
end
