defmodule FizzBuzzTest do
  use ExUnit.Case

  describe "build/1" do
    test "when a valid file is provided, returns the converted list" do
      expected_response = {:ok, [1, 2, :Fizz, 4, :Buzz, :Buzz, :FizzBuzz, :Buzz]}
      assert FizzBuzz.build('numbers.txt') == expected_response
    end

    test "when a invalid file is provided, returns the error message" do
      expected_response = {:error, "Error reading the file: enoent"}
      assert FizzBuzz.build('numberss.txt') == expected_response
    end
  end
end
