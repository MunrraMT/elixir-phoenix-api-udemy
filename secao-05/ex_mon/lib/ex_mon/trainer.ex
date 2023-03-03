defmodule ExMon.Trainer do
  use Ecto.Schema
  import Ecto.Changeset

  alias ExMon.Trainer.Pokemon

  @primary_key {:id, Ecto.UUID, autogenerate: true}
  @required_params [:name, :password]

  schema "trainers" do
    field(:name, :string)
    field(:password_hash, :string)
    field(:password, :string, virtual: true)
    has_many(:pokemon, Pokemon)
    timestamps()
  end

  def build(params) do
    params
    |> changeset()
    |> apply_action(:insert)
  end

  def changeset(params) do
    %__MODULE__{}
    |> create_changeset(params)
  end

  def changeset(trainer, params) do
    trainer
    |> create_changeset(params)
  end

  defp create_changeset(module_or_trainer, params) do
    module_or_trainer
    |> cast(params, @required_params)
    |> validate_required(@required_params)
    |> validate_length(:password, min: 6)
    |> put_pass_hash()
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset) do
    change(changeset, Argon2.add_hash(password))
  end

  defp put_pass_hash(%Ecto.Changeset{valid?: false} = changeset) do
    changeset
  end
end
