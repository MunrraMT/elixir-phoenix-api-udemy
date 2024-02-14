Mox.defmock(BananaBank.ViaCep.ClientBehaviourMock,
  for: BananaBank.ViaCep.ClientBehaviour
)

Application.put_env(
  :banana_bank,
  :via_cep_client,
  BananaBank.ViaCep.ClientBehaviourMock
)

ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(BananaBank.Repo, :manual)
