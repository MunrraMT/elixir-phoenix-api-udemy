defmodule FizzBuzz do
  def build(file_name) do
    file_name
    |> File.read()
    |> handle_file_read()
  end

  defp handle_file_read({:ok, result}) do
    result
    |> String.split(",")
    |> Enum.map(&convert_and_evaluate_numbers/1)
  end

  defp handle_file_read({:error, reason}) do
    "Error reading the file: #{reason}"
  end

  defp convert_and_evaluate_numbers(element) do
    element
    |> String.to_integer()
    |> evaluate_numbers()
  end

  defp evaluate_numbers(rem(number, 3) == 0), do: :Fizz
  defp evaluate_numbers(rem(number, 5) == 0), do: :Buzz
  defp evaluate_numbers(rem(number, 3) == 0 and rem(number, 5) == 0), do: :FizzBuzz
  defp evaluate_numbers(rem(number, 3) != 0 and rem(number, 5) != 0), do: :FizzBuzz
end
