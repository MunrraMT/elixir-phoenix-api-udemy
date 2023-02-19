defmodule FizzBuzz do
  def build(file_name) do
    file_name
    |> File.read()
    |> handle_file_read()
  end

  defp handle_file_read({:ok, result}), do: result
  defp handle_file_read({:error, reason}), do: reason
end
