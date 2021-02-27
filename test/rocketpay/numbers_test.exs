defmodule RocketPay.NumbersTest do
  use ExUnit.Case

  alias Rocketpay.Numbers

  describe "sum_from_file/1" do
    test "it should be able to sum integers in a file" do
      result = Numbers.sum_from_file("numbers")
      expected_result = {:ok, %{result: 45}}
      assert result == expected_result
    end

    test "it should not be able to sum integers in an invalid file" do
      result = Numbers.sum_from_file("banana")
      expected_result = {:error, %{message: "File not found."}}
      assert result == expected_result
    end
  end
end
