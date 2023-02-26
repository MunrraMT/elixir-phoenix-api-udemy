defmodule ExMon.Trainer.Create do
  alias ExMon.{Trainer, Repo}

  def call(params) do
    params
    |> Trainer.build()
    |> create_trainer()
  end

  defp create_trainer({:ok, struct}), do: Repo.insert(struct)
  defp create_trainer({:error, _struct} = error), do: error
end
