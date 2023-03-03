defmodule ExMonWeb.TrainersView do
  use ExMonWeb, :view

  alias ExMon.Trainer
  alias ExMonWeb.TrainerPokemonsView

  def render("create.json", %{
        trainer: %Trainer{id: id, name: name, inserted_at: inserted_at},
        token: token
      }) do
    %{
      message: "Trainer created!",
      trainer: %{
        id: id,
        name: name,
        inserted_at: inserted_at
      },
      token: token
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
      pokemons: render_many(pokemons, TrainerPokemonsView, "trainer_pokemon.json")
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
end
