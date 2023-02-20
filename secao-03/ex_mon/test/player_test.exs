defmodule ExMon.PlayerTest do
  use ExUnit.Case
  doctest ExMon.Player

  describe "build/1" do
    test "when recebe a valid provided arguments, returns the player struct" do
      expected_response = %ExMon.Player{
        life: 100,
        name: "André",
        move_rnd: :chute,
        move_avg: :soco,
        move_heal: :cura
      }

      assert ExMon.Player.build("André", :chute, :soco, :cura) == expected_response
    end
  end
end
