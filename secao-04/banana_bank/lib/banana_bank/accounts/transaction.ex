defmodule BananaBank.Accounts.Transaction do
  alias Ecto.Multi
  alias BananaBank.Repo
  alias BananaBank.Accounts
  alias BananaBank.Accounts.Account

  def call(
        %{
          "from_account_id" => from_account_id,
          "to_account_id" => to_account_id,
          "value" => value
        } = _params
      ) do
    with {:ok, %Account{} = from_account} <- Accounts.get(from_account_id),
         {:ok, %Account{} = to_account} <- Accounts.get(to_account_id),
         {:ok, valid_value} <- Decimal.cast(value) do
      Multi.new()
      |> withdraw(from_account, valid_value)
      |> deposit(to_account, valid_value)
      |> Repo.transaction()
      |> handle_transaction()
    else
      :error ->
        {:error, :invalid_value}

      {:error, :not_found} ->
        {:error, :not_found}

      _other_error ->
        :unexpected_error
    end
  end

  def call(_), do: {:error, "Invalid params"}

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

  defp handle_transaction({:ok, _result} = transaction), do: transaction

  defp handle_transaction({:error, _operation, reason, _} = _transaction) do
    {:error, reason}
  end
end
