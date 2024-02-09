defmodule BananaBank.Users.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Ecto.Changeset

  @field_required_list [:name, :password, :email, :cep]

  schema "users" do
    field(:name, :string)
    field(:password, :string, virtual: true)
    field(:password_hash, :string)
    field(:email, :string)
    field(:cep, :string)

    timestamps()
  end

  def changeset(user \\ %__MODULE__{}, params) do
    user
    |> cast(params, @field_required_list)
    |> validate_required(@field_required_list)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:name, min: 3)
    |> validate_length(:cep, is: 8)
    |> add_password_hash()
  end

  defp add_password_hash(
         %Changeset{
           valid?: true,
           changes: %{password: password}
         } = changeset
       ) do
    changeset
    |> change(password_hash: Argon2.hash_pwd_salt(password))
  end

  defp add_password_hash(changeset), do: changeset
end
