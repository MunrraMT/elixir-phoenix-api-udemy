defmodule BananaBank.Users.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Ecto.Changeset
  alias BananaBank.Accounts.Account

  @param_list [:name, :password, :email, :cep]
  @param_list_update [:name, :email, :cep]

  @derive {Jason.Encoder, except: [:__meta__, :password, :password_hash]}

  schema "users" do
    field(:name, :string)
    field(:password, :string, virtual: true)
    field(:password_hash, :string)
    field(:email, :string)
    field(:cep, :string)

    has_one :account, Account

    timestamps()
  end

  def changeset(params) do
    %__MODULE__{}
    |> cast(params, @param_list)
    |> do_validations(@param_list)
    |> add_password_hash()
  end

  def changeset(user, params) do
    user
    |> cast(params, @param_list)
    |> do_validations(@param_list_update)
    |> add_password_hash()
  end

  defp do_validations(user, fields) do
    user
    |> validate_required(fields)
    |> validate_format(:email, ~r/@/)
    |> validate_length(:name, min: 3)
    |> validate_length(:cep, is: 8)
    |> validate_length(:password, min: 6)
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
