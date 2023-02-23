defmodule ExMon.Game.Actions do
  alias ExMon.Game
  alias ExMon.Game.Actions.{Attack, Heal}

  def fetch_move(move_name) do
    Game.player()
    |> Map.get(:moves)
    |> find_move(move_name)
  end

  def attack(move) do
    case Game.turn() do
      :player -> Attack.attack_opponent(:computer, move)
      :computer -> Attack.attack_opponent(:player, move)
    end
  end

  def heal do
    case Game.turn() do
      :player -> Heal.heal_life(:player)
      :computer -> Heal.heal_life(:computer)
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
