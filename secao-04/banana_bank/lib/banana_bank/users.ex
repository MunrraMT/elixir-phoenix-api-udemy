defmodule BananaBank.Users do
  alias BananaBank.Users.Create

  defdelegate create(params), to: Create, as: :call
end
