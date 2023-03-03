defmodule ExMonWeb.TrainerPokemonsController do
  use ExMonWeb, :controller

  action_fallback(ExMonWeb.FallbackController)

  def create(conn, params) do
    params
    |> ExMon.create_trainer_pokemon()
    |> handle_response(conn, "create.json", :created)
  end

  defp handle_response({:error, _reason} = error, _conn, _view, _status_code), do: error

  defp handle_response({:ok, pokemon}, conn, view, status_code) do
    conn
    |> put_status(status_code)
    |> render(view, pokemon: pokemon)
  end
end
