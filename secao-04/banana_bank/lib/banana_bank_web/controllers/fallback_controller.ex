defmodule BananaBankWeb.FallbackController do
  use BananaBankWeb, :controller

  alias BananaBankWeb.ErrorJSON
  alias Ecto.Changeset

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(json: ErrorJSON)
    |> render(:error, status: :not_found, struct: "User")
  end

  def call(conn, {:error, %Changeset{} = changeset}) do
    conn
    |> put_status(:bad_request)
    |> put_view(json: ErrorJSON)
    |> render(:error, changeset: changeset)
  end
end
