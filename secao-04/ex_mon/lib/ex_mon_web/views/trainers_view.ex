defmodule ExMonWeb.TrainersView do
  use ExMonWeb, :view

  alias ExMon.Trainer
  alias ExMon.Trainer.Pokemon

  def render("create.json", %{trainer: %Trainer{id: id, name: name, inserted_at: inserted_at}}) do
    %{
      message: "Trainer created!",
      trainer: %{
        id: id,
        name: name,
        inserted_at: inserted_at
      }
    }
  end

  def render("show.json", %{
        trainer: %Trainer{
          id: id,
          name: name,
          inserted_at: inserted_at,
          pokemon: pokemons
        }
      }) do
    %{
      id: id,
      name: name,
      inserted_at: inserted_at,
      pokemons: render_many(pokemons, __MODULE__, "trainer_pokemon.json")
    }
  end

  def render("update.json", %{
        trainer: %Trainer{id: id, name: name, inserted_at: inserted_at, updated_at: updated_at}
      }) do
    %{
      message: "Trainer updated!",
      trainer: %{
        id: id,
        name: name,
        inserted_at: inserted_at,
        updated_at: updated_at
      }
    }
  end

  def render("trainer_pokemon.json", %{
        trainers: %Pokemon{id: id, name: name, nickname: nickname, types: types}
      }) do
    %{id: id, name: name, nickname: nickname, types: types}
  end
end
