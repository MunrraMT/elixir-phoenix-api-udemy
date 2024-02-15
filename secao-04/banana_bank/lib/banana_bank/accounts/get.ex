defmodule BananaBank.Accounts.Get do
  alias BananaBank.Repo
  alias BananaBank.Accounts.Account

  def call(account_id) do
    case Repo.get(Account, account_id) do
      nil -> {:error, :not_found}
      account -> {:ok, account}
    end
  end
end
