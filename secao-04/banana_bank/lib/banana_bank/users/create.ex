defmodule BananaBank.Users.Create do
  alias BananaBank.ViaCep.Client
  alias BananaBank.Users.User
  alias BananaBank.Repo

  def call(%{"cep" => cep} = params) do
    with {:ok, _result} <- Client.call(cep) do
      params
      |> User.changeset()
      |> Repo.insert()
    end
  end
end
