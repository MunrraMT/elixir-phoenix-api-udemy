defmodule ExMon.Trainer.Pokemon.Get do
  alias ExMon.{Repo, Trainer.Pokemon}
  alias Ecto.UUID

  def call(uuid) do
    case UUID.cast(uuid) do
      :error -> {:error, "Invalid ID format!"}
      {:ok, uuid} -> get(uuid)
    end
  end

  defp get(uuid) do
    case fetch_pokemon(uuid) do
      nil -> {:error, "Pokemon not found!"}
      pokemon -> {:ok, Repo.preload(pokemon, :trainer)}
    end
  end

  defp fetch_pokemon(uuid), do: Repo.get(Pokemon, uuid)
end
