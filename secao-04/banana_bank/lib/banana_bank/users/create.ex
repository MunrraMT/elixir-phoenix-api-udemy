defmodule BananaBank.Users.Create do
  alias BananaBank.{Repo, Users.User}

  def call(params) do
    params
    |> User.changeset()
    |> Repo.insert()
  end
end
