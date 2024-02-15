defmodule BananaBankWeb.UsersJSON do
  alias BananaBank.Users.User

  def create(%{user: user}) do
    %{
      message: "User criado com sucesso!",
      data: data(user)
    }
  end

  def get(%{user: user}), do: %{data: data(user)}
  def delete(%{user: user}), do: %{data: data(user)}

  def update(%{user: user}) do
    %{
      message: "User atualizado com sucesso!",
      data: data(user)
    }
  end

  def login(%{token: token}) do
    %{
      message: "User Autenticado com sucesso!",
      bearer: token
    }
  end

  defp data(%User{} = user) do
    %{
      id: user.id,
      name: user.name,
      email: user.email,
      cep: user.cep
    }
  end
end
