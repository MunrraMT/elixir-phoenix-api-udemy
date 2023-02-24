defmodule ExMon.GameTest do
  use ExUnit.Case

  alias ExMon.{Game, Player}

  setup do
    player = Player.build("André", :chute, :soco, :cura)
    computer = Player.build("Computer", :chute, :soco, :cura)
    start_info = Game.start(computer, player)

    {:ok, start_info: start_info, player_data: player, computer_data: computer}
  end

  describe "start/2" do
    test "starts the game state", state do
      assert {:ok, _pid} = Map.get(state, :start_info)
    end
  end

  describe "info/0" do
    test "returns the current game state" do
      expected_response = %{
        computer: %ExMon.Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Computer"
        },
        player: %ExMon.Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "André"
        },
        status: :started,
        turn: :player
      }

      assert Game.info() == expected_response
    end
  end

  describe "update/1" do
    test "returns the game state " do
      start_state = %{
        computer: %ExMon.Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Computer"
        },
        player: %ExMon.Player{
          life: 100,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "André"
        },
        status: :started,
        turn: :player
      }

      assert Game.info() == start_state

      new_state = %{
        computer: %ExMon.Player{
          life: 85,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "Computer"
        },
        player: %ExMon.Player{
          life: 50,
          moves: %{move_avg: :soco, move_heal: :cura, move_rnd: :chute},
          name: "André"
        },
        status: :started,
        turn: :player
      }

      Game.update(new_state)

      expected_response = %{new_state | turn: :computer, status: :continue}

      assert Game.info() == expected_response
    end
  end

  describe "player/0" do
    test "returns player info", state do
      expected_response = Map.get(state, :player_data)
      assert Game.player() == expected_response
    end
  end

  describe "turn/0" do
    test "returns turn info", state do
      expected_response = Game.info() |> Map.get(:turn)

      assert Game.turn() == expected_response
    end
  end

  describe "fetch_player/0" do
    test "returns player or computer info", state do
      expected_response_player = Game.info() |> Map.get(:player)
      expected_response_computer = Game.info() |> Map.get(:computer)

      assert Game.fetch_player(:player) == expected_response_player
      assert Game.fetch_player(:computer) == expected_response_computer
    end
  end
end
