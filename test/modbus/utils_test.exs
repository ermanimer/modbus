defmodule Modbus.UtilsTest do
  use ExUnit.Case

  test "parse_big_uint" do
    assert Modbus.Utils.parse_big_uint(<<0, 0, 1>>, 1, 16) == {:ok, 1}
    assert Modbus.Utils.parse_big_uint(<<0>>, 1, 16) == {:error, :invalid_data_size}
  end

  test "parse_big_int" do
    assert Modbus.Utils.parse_big_int(<<0, 255, 254>>, 1, 16) == {:ok, -2}
    assert Modbus.Utils.parse_big_int(<<0>>, 1, 16) == {:error, :invalid_data_size}
  end

  test "parse_big_float" do
    assert Modbus.Utils.parse_big_float(<<0, 63, 128, 0, 0>>, 1, 32) == {:ok, 1}
    assert Modbus.Utils.parse_big_float(<<0>>, 1, 32) == {:error, :invalid_data_size}
  end

  test "parse_little_uint" do
    assert Modbus.Utils.parse_little_uint(<<0, 1, 0>>, 1, 16) == {:ok, 1}
    assert Modbus.Utils.parse_little_uint(<<0>>, 1, 16) == {:error, :invalid_data_size}
  end

  test "parse_little_int" do
    assert Modbus.Utils.parse_little_int(<<0, 254, 255>>, 1, 16) == {:ok, -2}
    assert Modbus.Utils.parse_little_int(<<0>>, 1, 16) == {:error, :invalid_data_size}
  end

  test "parse_little_float" do
    assert Modbus.Utils.parse_little_float(<<0, 0, 0, 128, 63>>, 1, 32) == {:ok, 1}
    assert Modbus.Utils.parse_little_float(<<0>>, 1, 32) == {:error, :invalid_data_size}
  end
end
