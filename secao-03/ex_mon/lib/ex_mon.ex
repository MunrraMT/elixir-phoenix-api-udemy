defmodule ExMon do
  alias ExMon.{Game, Player}
  alias ExMon.Game.{Actions, Status}

  @computer_name "Robotinik"
  @computer_moves [:move_avg, :move_rnd, :move_heal]

  def create_player(name, move_rnd, move_avg, move_heal) do
    Player.build(name, move_rnd, move_avg, move_heal)
  end

  def start_game(player) do
    @computer_name
    |> create_player(:punch, :kick, :heal)
    |> Game.start(player)

    Game.info()
    |> Status.print_round_message()
  end

  def make_move(move_name) do
    Game.info()
    |> Map.get(:status)
    |> handle_status(move_name)
  end

  defp handle_status(:game_over, _move_name) do
    :game_over
  end

  defp handle_status(_other, move_name) do
    move_name
    |> Actions.fetch_move()
    |> do_move()

    Game.info()
    |> computer_move()
  end

  defp do_move({:error, move}) do
    Status.print_wrong_move_message(move)
  end

  defp do_move({:ok, move}) do
    case move do
      :move_heal -> Actions.heal()
      move -> Actions.attack(move)
    end

    Game.info()
    |> Status.print_round_message()
  end

  defp computer_move(%{turn: :computer, status: :continue}) do
    move =
      @computer_moves
      |> Enum.random()

    do_move({:ok, move})
  end

  defp computer_move(_), do: :ok
end
