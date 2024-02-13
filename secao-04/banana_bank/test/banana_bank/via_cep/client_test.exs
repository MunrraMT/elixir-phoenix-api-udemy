defmodule BananaBank.ViaCep.ClientTest do
  use ExUnit.Case, async: true
  alias BananaBank.ViaCep.Client

  setup do
    bypass = Bypass.open()
    {:ok, bypass: bypass}
  end

  describe "call/1" do
    test "returns cep info if valid cep", %{bypass: bypass} do
      # Bypass.expect(bypass, fn conn ->
      #   Plug.Conn.resp(conn, 200, "")
      # end)

      assert %{} == Client.call("01001000")
    end
  end
end
