defmodule ExMon.Game.Actions do
  alias ExMon.Game

  def fetch_move(move_name) do
    Game.player()
    |> Map.get(:moves)
    |> find_move(move_name)
  end

  def attack(move) do
  end

  defp find_move(moves, move_name) do
    Enum.find_value(moves, {:error, move_name}, fn {key, value} ->
      if value == move_name do
        {:ok, key}
      end
    end)
  end
end
