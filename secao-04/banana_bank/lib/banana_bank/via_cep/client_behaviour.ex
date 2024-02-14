defmodule BananaBank.ViaCep.ClientBehaviour do
  @callback call(String.t()) :: {:error, :atom} | {:ok, map()}
end
