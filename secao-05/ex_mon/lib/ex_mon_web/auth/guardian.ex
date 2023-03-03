defmodule ExMonWeb.Auth.Guardian do
  use Guardian, otp_app: :ex_mon

  alias ExMon.{Repo, Trainer}

  def subject_for_token(%{id: id}, _claims) do
    sub = to_string(id)
    {:ok, sub}
  end

  def resource_from_claims(%{"sub" => id}) do
    id
    |> ExMon.fetch_trainer()
  end

  def authenticate(%{"id" => trainer_id, "password" => password}) do
    case Repo.get(Trainer, trainer_id) do
      nil -> {:error, "Trainer not found!"}
      trainer -> validate_password(trainer, password)
    end
  end

  defp validate_password(%Trainer{password_hash: hash} = trainer, password) do
    case Argon2.verify_pass(password, hash) do
      true -> create_token(trainer)
      false -> {:error, :unauthorized}
    end
  end

  defp create_token(trainer) do
    {:ok, token, _claims} = encode_and_sign(trainer)
    {:ok, token}
  end
end
