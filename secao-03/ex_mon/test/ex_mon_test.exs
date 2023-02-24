defmodule ExMonTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ExMon.{Player}

  describe "create_player/4" do
    test "returns a player" do
      expected_response = %Player{
        life: 100,
        moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
        name: "André"
      }

      assert ExMon.create_player("André", :chute, :soco, :cura) == expected_response
    end
  end

  describe "start_game/1" do
    player = %Player{
      life: 100,
      moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
      name: "André"
    }

    messages = capture_io(fn -> assert ExMon.start_game(player) == :ok end)

    assert messages =~ "The game is started!"
    assert messages =~ "status: :started"
    assert messages =~ "turn: :player"
  end
end
