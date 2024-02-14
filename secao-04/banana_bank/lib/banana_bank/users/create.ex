defmodule BananaBank.Users.Create do
  alias BananaBank.Users.User
  alias BananaBank.Repo
  alias BananaBank.ViaCep.Client, as: ViaCepClient

  def call(%{"cep" => cep} = params) do
    with {:ok, _result} <- via_cep_client().call(cep) do
      params
      |> User.changeset()
      |> Repo.insert()
    end
  end

  defp via_cep_client() do
    Application.get_env(:banana_bank, :via_cep_client, ViaCepClient)
  end
end
