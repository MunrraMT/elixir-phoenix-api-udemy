defmodule ExMon.Game.Status do
  alias ExMon.Game

  def print_round_message do
    IO.puts("\nThe game is started!")

    Game.info()
    |> IO.inspect()

    IO.puts("------------")
  end
end
