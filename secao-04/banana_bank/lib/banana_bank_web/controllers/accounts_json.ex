defmodule BananaBankWeb.AccountsJSON do
  alias BananaBank.Accounts.Account

  def create(%{account: account}) do
    %{
      message: "Conta criado com sucesso!",
      data: data(account)
    }
  end

  def transaction(%{
        transaction:
          %{
            deposit: to_account,
            withdraw: from_account
          } = _transaction
      }) do
    %{
      message: "Transferência realizada com sucesso!",
      data: %{
        deposit: data(to_account),
        withdraw: data(from_account)
      }
    }
  end

  defp data(%Account{} = account) do
    %{
      id: account.id,
      balance: account.balance,
      user_id: account.user_id
    }
  end
end
