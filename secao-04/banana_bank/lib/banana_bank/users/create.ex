defmodule BananaBank.Users.Create do
  alias BananaBank.Users.User
  alias BananaBank.Repo

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end
end
