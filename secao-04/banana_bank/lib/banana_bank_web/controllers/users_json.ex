defmodule BananaBankWeb.UsersJSON do
  def create(%{user: user}) do
    %{
      message: "User criado com sucesso!",
      data: user
    }
  end

  def get(%{user: user}), do: %{data: user}
  def delete(%{user: user}), do: %{data: user}

  def update(%{user: user}) do
    %{
      message: "User atualizado com sucesso!",
      data: user
    }
  end
end
