defmodule ExMonWeb.Auth.Guardian do
  use Guardian, otp_app: :ex_mon

  def subject_for_token(%{id: id}, _claims) do
    sub = to_string(id)
    {:ok, sub}
  end

  def resource_from_claims(%{"sub" => id}) do
    id
    |> ExMon.fetch_trainer()
  end
end
