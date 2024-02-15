defmodule BananaBank.Users.Verify do
  alias BananaBank.Users.User
  alias BananaBank.Users

  def call(%{user_id: user_id, password: password}) do
    case Users.get(user_id) do
      {:ok, %User{password_hash: password_hash} = _user} ->
        verify(password, password_hash)

      error ->
        error
    end
  end

  defp verify(password, password_hash) do
    case Argon2.verify_pass(password, password_hash) do
      true -> {:ok, :valid_password}
      false -> {:error, :unauthorized}
    end
  end
end
