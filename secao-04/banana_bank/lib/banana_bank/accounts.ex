defmodule BananaBank.Accounts do
  alias BananaBank.Accounts.Get
  alias BananaBank.Accounts.Create

  defdelegate create(params), to: Create, as: :call
  defdelegate get(account_id), to: Get, as: :call
end
