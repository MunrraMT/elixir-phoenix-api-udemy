defmodule ExMon.Trainer.Get do
  alias ExMon.{Repo, Trainer}
  alias Ecto.UUID

  def call(uuid) do
    case UUID.cast(uuid) do
      :error -> {:error, "Invalid ID format!"}
      {:ok, uuid} -> get(uuid)
    end
  end

  defp get(uuid) do
    case fetch_trainer(uuid) do
      nil -> {:error, "Trainer not found!"}
      trainer -> {:ok, Repo.preload(trainer, :pokemon)}
    end
  end

  defp fetch_trainer(uuid), do: Repo.get(Trainer, uuid)
end
