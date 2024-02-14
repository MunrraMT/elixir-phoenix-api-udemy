defmodule BananaBank.Accounts do
  alias BananaBank.Accounts.Create

  defdelegate create(params), to: Create, as: :call
end
