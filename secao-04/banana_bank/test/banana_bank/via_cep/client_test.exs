defmodule BananaBank.ViaCep.ClientTest do
  use ExUnit.Case, async: true
  alias BananaBank.ViaCep.Client

  setup do
    bypass = Bypass.open()
    {:ok, bypass: bypass}
  end

  defp endpoint_url(port), do: "http://localhost:#{port}/"

  describe "call/1" do
    test "returns cep info if valid cep", %{bypass: bypass} do
      expected_response =
        ~s<{
          "bairro": "Sé",
          "cep": "01001-000",
          "complemento": "lado ímpar",
          "ddd": "11",
          "gia": "1004",
          "ibge": 3550308",
          "localidade": "São Paulo",
          "logradouro": "Praça da Sé","
          siafi": "7107",
          "uf": "SP"
          }>

      Bypass.expect(bypass, fn conn ->
        Plug.Conn.resp(
          conn,
          200,
          expected_response
        )
      end)

      response =
        bypass.port
        |> endpoint_url()
        |> Client.call("01001000")

      assert {:ok, expected_response} == response
    end
  end
end
