defmodule BananaBankWeb.Plugs.Auth do
  alias Phoenix.Controller
  alias Plug.Conn
  alias BananaBankWeb.Token
  alias BananaBankWeb.ErrorJSON

  def init(opts), do: opts

  def call(conn, _opts) do
    with ["Bearer " <> token] <- Conn.get_req_header(conn, "authorization"),
         {:ok, data} <- Token.verify(token) do
      conn
      |> check_if_owner_of_token(data.user_id)
    else
      _error ->
        error_throw(conn)
    end
  end

  defp check_if_owner_of_token(%{params: %{"id" => id}} = conn, user_id) do
    case id == to_string(user_id) do
      true ->
        conn
        |> Conn.assign(:user_id, user_id)

      false ->
        conn
        |> error_throw()
    end
  end

  defp error_throw(conn) do
    conn
    |> Conn.put_status(:unauthorized)
    |> Controller.put_view(json: ErrorJSON)
    |> Controller.render(:error, status: :unauthorized)
    |> Conn.halt()
  end
end
