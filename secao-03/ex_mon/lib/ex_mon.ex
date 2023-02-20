defmodule ExMon do
  alias ExMon.Player

  def create_player(name, move_rnd, move_avg, move_heal) do
    Player.build(name, move_rnd, move_avg, move_heal)
  end
end
