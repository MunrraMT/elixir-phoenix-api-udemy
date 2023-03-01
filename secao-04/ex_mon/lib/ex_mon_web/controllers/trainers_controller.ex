defmodule ExMonWeb.TrainersController do
  use ExMonWeb, :controller

  action_fallback(ExMonWeb.FallbackController)

  def create(conn, params) do
    params
    |> ExMon.create_trainer()
    |> handle_response(conn, :create)
  end

  def delete(conn, %{"id" => id}) do
    id
    |> ExMon.delete_trainer()
    |> handle_response(conn, :delete)
  end

  defp handle_response({:ok, trainer}, conn, :create) do
    conn
    |> put_status(:created)
    |> render("create.json", trainer: trainer)
  end

  defp handle_response({:ok, __trainer}, conn, :delete) do
    conn
    |> put_status(:no_content)
    |> text("")
  end

  defp handle_response({:error, __reason} = error, __conn, __method), do: error
end
