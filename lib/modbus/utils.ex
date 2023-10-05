defmodule Modbus.Utils do
  def parse_big_uint(data, byte_ofset, bit_size) when bit_size in [16, 32, 64] do
    case extract(data, byte_ofset, bit_size) do
      {:ok, extracted_data} ->
        <<value::big-unsigned-integer-size(bit_size)>> = extracted_data
        {:ok, value}

      {:error, reason} ->
        {:error, reason}
    end
  end

  def parse_big_int(data, byte_ofset, bit_size) when bit_size in [16, 32, 64] do
    case extract(data, byte_ofset, bit_size) do
      {:ok, extracted_data} ->
        <<value::big-signed-integer-size(bit_size)>> = extracted_data
        {:ok, value}

      {:error, reason} ->
        {:error, reason}
    end
  end

  def parse_big_float(data, byte_ofset, bit_size) when bit_size in [32, 64] do
    case extract(data, byte_ofset, bit_size) do
      {:ok, extracted_data} ->
        <<value::big-float-size(bit_size)>> = extracted_data
        {:ok, value}

      {:error, reason} ->
        {:error, reason}
    end
  end

  def parse_little_uint(data, byte_ofset, bit_size) when bit_size in [16, 32, 64] do
    case extract(data, byte_ofset, bit_size) do
      {:ok, extracted_data} ->
        <<value::little-unsigned-integer-size(bit_size)>> = extracted_data
        {:ok, value}

      {:error, reason} ->
        {:error, reason}
    end
  end

  def parse_little_int(data, byte_ofset, bit_size) when bit_size in [16, 32, 64] do
    case extract(data, byte_ofset, bit_size) do
      {:ok, extracted_data} ->
        <<value::little-signed-integer-size(bit_size)>> = extracted_data
        {:ok, value}

      {:error, reason} ->
        {:error, reason}
    end
  end

  def parse_little_float(data, byte_ofset, bit_size) when bit_size in [32, 64] do
    case extract(data, byte_ofset, bit_size) do
      {:ok, extracted_data} ->
        <<value::little-float-size(bit_size)>> = extracted_data
        {:ok, value}

      {:error, reason} ->
        {:error, reason}
    end
  end

  def extract(data, byte_offset, bit_size) when byte_size(data) >= byte_offset + bit_size / 8 do
    <<_::byte_offset*8, value::size(bit_size), _::binary>> = data
    {:ok, <<value::size(bit_size)>>}
  end

  def extract(_data, _byte_offset, _bit_size) do
    {:error, :invalid_data_size}
  end
end
