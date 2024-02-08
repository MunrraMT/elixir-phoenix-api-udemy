defmodule ExMon.Trainer.Pokemon.Update do
  alias ExMon.{Repo, Trainer.Pokemon}
  alias Ecto.UUID

  def call(%{"id" => uuid} = params) do
    case UUID.cast(uuid) do
      :error -> {:error, "Invalid ID format!"}
      {:ok, uuid} -> update(uuid, params)
    end
  end

  defp update(uuid, params) do
    case fetch_pokemon(uuid) do
      nil -> {:error, "Pokemon not found!"}
      pokemon -> update_pokemon(pokemon, params)
    end
  end

  defp fetch_pokemon(uuid), do: Repo.get(Pokemon, uuid)

  defp update_pokemon(pokemon, params) do
    pokemon
    |> Pokemon.update_changeset(params)
    |> Repo.update()
  end
end
