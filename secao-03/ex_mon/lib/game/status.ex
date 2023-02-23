defmodule ExMon.Game.Status do
  def print_round_message(%{status: :started} = status) do
    IO.puts("\nThe game is started!")

    status
    |> IO.inspect()

    IO.puts("------------")
  end

  def print_round_message(%{status: :continue, turn: player} = status) do
    IO.puts("\nIt's #{player} turn!")

    status
    |> IO.inspect()

    IO.puts("------------")
  end

  def print_round_message(%{status: :game_over} = status) do
    IO.puts("\nThe game is over!")

    status
    |> IO.inspect()

    IO.puts("------------")
  end

  def print_wrong_move_message(move) do
    IO.puts("\ninvalid move: #{move}!")
  end

  def print_move_message(:computer, :attack, damage) do
    IO.puts("\nThe Player attacked the Computer dealing: #{damage} damage.")
  end

  def print_move_message(:player, :attack, damage) do
    IO.puts("\nThe Computer attacked the Player dealing: #{damage} damage.")
  end

  def print_move_message(player, :heal, life) do
    IO.puts("\nThe #{player} healed itself to: #{life} life points.")
  end
end
