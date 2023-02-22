defmodule ExMon.Game do
  alias ExMon.Player

  use Agent

  def start(computer, player) do
    initial_value = %{computer: computer, player: player, turn: :player, status: :started}
    Agent.start_link(fn -> initial_value end, name: __MODULE__)
  end

  def info do
    Agent.get(__MODULE__, & &1)
  end

  def update(state) do
    Agent.update(__MODULE__, fn _ -> update_game_status(state) end)
  end

  def player do
    info()
    |> Map.get(:player)
  end

  def turn do
    info()
    |> Map.get(:turn)
  end

  def fetch_player(player) do
    info()
    |> Map.get(player)
  end

  defp update_game_status(
         %{
           player: %Player{life: player_life},
           computer: %Player{life: computer_life}
         } = state
       )
       when player_life == 0 or computer_life == 0 do
    state
    |> Map.put(:status, :game_over)
  end

  defp update_game_status(status) do
    status
    |> Map.put(:status, :continue)
    |> update_turn()
  end

  defp update_turn(%{turn: :player} = status) do
    status
    |> Map.put(:turn, :computer)
  end

  defp update_turn(%{turn: :computer} = status) do
    status
    |> Map.put(:turn, :player)
  end
end
