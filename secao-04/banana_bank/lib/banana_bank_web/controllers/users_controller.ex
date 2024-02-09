defmodule BananaBankWeb.UsersController do
  use BananaBankWeb, :controller
  alias BananaBank.Users.Create

  def create(conn, params) do
    params
    |> Create.call()
    |> handle_response(conn)
  end

  defp handle_response({:ok, user}, conn) do
    conn
    |> put_status(:created)
    |> render(:create, user: user)
  end

  # defp handle_response({:error, _changeset} = error, conn) do
  #   conn
  #   |> put_status(:bad_request)
  #   |> render("error.json", error: error)
  # end
end
