defmodule BananaBankWeb.WelcomeController do
  use BananaBankWeb, :controller

  def index(conn, _params) do
    IO.inspect(conn)

    conn
    |> put_status(:ok)
    |> json(%{message: "Bem vindo", status: "ok"})
  end
end
