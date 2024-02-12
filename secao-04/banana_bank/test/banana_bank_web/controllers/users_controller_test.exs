defmodule BananaBankWeb.UsersControllerTest do
  use BananaBankWeb.ConnCase, async: true

  @create_attrs %{
    name: "João",
    cep: "12345678",
    email: "teste@teste.com",
    password: "123456"
  }

  describe "create/2" do
    test "successfully creates an user", %{conn: conn} do
      conn = post(conn, ~p"/api/users", @create_attrs)

      assert %{
               "data" => %{
                 "id" => _id,
                 "name" => "João",
                 "cep" => "12345678",
                 "email" => "teste@teste.com"
               },
               "message" => "User criado com sucesso!"
             } = json_response(conn, :created)
    end
  end
end
