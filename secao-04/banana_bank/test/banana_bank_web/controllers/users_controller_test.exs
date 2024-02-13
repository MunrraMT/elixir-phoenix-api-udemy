defmodule BananaBankWeb.UsersControllerTest do
  alias BananaBank.Users
  use BananaBankWeb.ConnCase, async: true

  @create_attrs %{
    name: "João",
    cep: "01001000",
    email: "teste@teste.com",
    password: "123456"
  }

  @invalid_attrs %{
    name: "Jo",
    cep: "123",
    email: "teste",
    password: "123"
  }

  describe "create/2" do
    test "returns success, if correct params", %{conn: conn} do
      conn = post(conn, ~p"/api/users", @create_attrs)

      assert %{
               "data" => %{
                 "id" => _id,
                 "name" => "João",
                 "cep" => "01001000",
                 "email" => "teste@teste.com"
               },
               "message" => "User criado com sucesso!"
             } = json_response(conn, :created)
    end

    test "returns errors, if empty params", %{conn: conn} do
      conn = post(conn, ~p"/api/users", %{})

      assert %{
               "errors" => %{
                 "cep" => ["should be 8 character(s)"],
                 "email" => ["has invalid format"],
                 "name" => ["should be at least 3 character(s)"],
                 "password" => ["should be at least 6 character(s)"]
               }
             } = json_response(conn, :bad_request)
    end

    test "returns errors, if invalid params", %{conn: conn} do
      conn = post(conn, ~p"/api/users", @invalid_attrs)

      assert %{
               "errors" => %{
                 "cep" => ["should be 8 character(s)"],
                 "email" => ["has invalid format"],
                 "name" => ["should be at least 3 character(s)"],
                 "password" => ["should be at least 6 character(s)"]
               }
             } = json_response(conn, :bad_request)
    end
  end

  describe "delete/1" do
    test "returns success, if valid id", %{conn: conn} do
      {:ok, %{id: id} = _user} = Users.create(@create_attrs)

      conn = delete(conn, ~p"/api/users/#{id}")
      %{"data" => %{"id" => id_response}} = json_response(conn, :ok)
      assert to_string(id) == id_response

      conn = get(conn, ~p"/api/users/#{id}")
      assert json_response(conn, :not_found)
    end
  end
end
