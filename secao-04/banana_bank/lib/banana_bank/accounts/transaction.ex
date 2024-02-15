defmodule BananaBank.Accounts.Transaction do
  alias Ecto.Multi
  alias BananaBank.Repo
  alias BananaBank.Accounts
  alias BananaBank.Accounts.Account

  def call(from_account_id, to_account_id, value) do
    with {:ok, %Account{} = from_account} <- Accounts.get(from_account_id),
         {:ok, %Account{} = to_account} <- Accounts.get(to_account_id),
         {:ok, value} = Decimal.cast(value) do
      Multi.new()
      |> withdraw(from_account, value)
      |> deposit(to_account, value)
      |> Repo.transaction()
    else
      :error ->
        {:error, :invalid_value}

      {:error, :not_found} ->
        {:error, :not_found}

      _other_error ->
        :unexpected_error
    end
  end

  defp withdraw(multi, %Account{} = from_account, value) do
    new_balance = Decimal.sub(from_account.balance, value)
    changeset = Account.changeset(from_account, %{balance: new_balance})
    Multi.update(multi, :withdraw, changeset)
  end

  defp deposit(multi, %Account{} = to_account, value) do
    new_balance = Decimal.add(to_account.balance, value)
    changeset = Account.changeset(to_account, %{balance: new_balance})
    Multi.update(multi, :deposit, changeset)
  end
end
