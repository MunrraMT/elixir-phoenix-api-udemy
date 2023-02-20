defmodule ExMon.Game.Status do
  alias ExMon.Game

  def print_round_message do
    IO.puts("\nThe game is started!")

    Game.info()
    |> IO.inspect()

    IO.puts("------------")
  end

  def print_wrong_move_message(move) do
    IO.puts("\ninvalid move: #{move}!")
  end
end
