defmodule ExMonTest do
  use ExUnit.Case
  doctest ExMon

  describe "create_player/4" do
    test "when recebe a valid provided, call ExMon.Player.build" do
      expected_response = %ExMon.Player{
        life: 100,
        name: "André",
        move_rnd: :chute,
        move_avg: :soco,
        move_heal: :cura
      }

      assert ExMon.create_player("André", :chute, :soco, :cura) == expected_response
    end
  end
end
