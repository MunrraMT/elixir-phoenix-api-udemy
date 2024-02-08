defmodule Teste.Repo do
  use Ecto.Repo,
    otp_app: :teste,
    adapter: Ecto.Adapters.Postgres
end
