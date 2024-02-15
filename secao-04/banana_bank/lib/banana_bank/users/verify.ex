defmodule BananaBank.Users.Verify do
  alias BananaBank.Users.User
  alias BananaBank.Users

  def call(user_id, password) do
    case Users.get(user_id) do
      {:ok, %User{} = user} ->
        verify(password, user)

      error ->
        error
    end
  end

  defp verify(password, %User{} = user) do
    case Argon2.verify_pass(password, user.password_hash) do
      true -> {:ok, user}
      false -> {:error, :unauthorized}
    end
  end
end
