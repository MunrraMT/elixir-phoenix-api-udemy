defmodule ExMon.Game.Actions do
  alias ExMon.Game
  alias ExMon.Game.Actions.Attack

  def fetch_move(move_name) do
    Game.player()
    |> Map.get(:moves)
    |> find_move(move_name)
  end

  def attack(move) do
    case Game.turn() do
      :player -> Attack.attack_opponnent(:computer, move)
      :computer -> Attack.attack_opponnent(:player, move)
    end
  end

  defp find_move(moves, move_name) do
    Enum.find_value(moves, {:error, move_name}, fn {key, value} ->
      if value == move_name do
        {:ok, key}
      end
    end)
  end
end
