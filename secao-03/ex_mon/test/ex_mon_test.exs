defmodule ExMonTest do
  use ExUnit.Case

  import ExUnit.CaptureIO

  alias ExMon.{Game, Player}

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

    messages =
      capture_io(fn ->
        assert ExMon.start_game(player) == :ok
      end)

    assert messages =~ "The game is started!"
    assert messages =~ "status: :started"
    assert messages =~ "turn: :player"
  end

  describe "make_move/1" do
    setup do
      player = ExMon.create_player("André", :chute, :soco, :cura)

      capture_io(fn ->
        ExMon.start_game(player)
      end)

      :ok
    end

    test "when the move is valid do the move and the computer makes a move" do
      messages =
        capture_io(fn ->
          ExMon.make_move(:chute)
        end)

      assert messages =~ "Player attacked the Computer dealing"
      assert messages =~ "It's computer turn!"
      assert messages =~ "It's player turn!"
      assert messages =~ "status: :continue"
    end

    test "when the move is invalid, returns an error message" do
      messages =
        capture_io(fn ->
          ExMon.make_move(:wrong)
        end)

      assert messages =~ "invalid move: wrong!"
    end
  end
end
