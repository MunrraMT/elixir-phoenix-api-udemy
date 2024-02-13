defmodule BananaBankWeb.UsersControllerTest do
  alias BananaBank.Users
  use BananaBankWeb.ConnCase, async: true

  @valid_attrs %{
    "name" => "João",
    "cep" => "01001000",
    "email" => "teste@teste.com",
    "password" => "123456"
  }

  @invalid_attrs %{
    "name" => "Jo",
    "cep" => "123",
    "email" => "teste",
    "password" => "123"
  }

  @valid_cep "01001000"
  @invalid_cep "00000000"

  @valid_attrs_with_empty_cep Map.put(@valid_attrs, "cep", "")
  @valid_attrs_except_cep Map.put(@valid_attrs, "cep", @invalid_cep)
  @invalid_attrs_except_cep Map.put(@invalid_attrs, "cep", @valid_cep)

  describe "create/2" do
    test "returns success, if correct params", %{conn: conn} do
      conn = post(conn, ~p"/api/users", @valid_attrs)

      assert %{
               "data" => %{
                 "id" => _id,
                 "name" => "João",
                 "cep" => @valid_cep,
                 "email" => "teste@teste.com"
               },
               "message" => "User criado com sucesso!"
             } = json_response(conn, :created)
    end

    test "returns errors, if empty cep", %{conn: conn} do
      conn = post(conn, ~p"/api/users", @valid_attrs_with_empty_cep)

      assert %{"status" => "bad_request"} = json_response(conn, :bad_request)
    end

    test "returns errors, if invalid cep", %{conn: conn} do
      conn = post(conn, ~p"/api/users", @valid_attrs_except_cep)

      assert %{"status" => "resource_not_found"} = json_response(conn, :ok)
    end

    test "returns errors, if empty params, except cep", %{conn: conn} do
      conn = post(conn, ~p"/api/users", %{"cep" => @valid_cep})

      assert %{
               "errors" => %{
                 "email" => ["can't be blank"],
                 "name" => ["can't be blank"],
                 "password" => ["can't be blank"]
               }
             } = json_response(conn, :bad_request)
    end

    test "returns errors, if invalid params, except cep", %{conn: conn} do
      conn = post(conn, ~p"/api/users", @invalid_attrs_except_cep)

      assert %{
               "errors" => %{
                 "email" => ["has invalid format"],
                 "name" => ["should be at least 3 character(s)"],
                 "password" => ["should be at least 6 character(s)"]
               }
             } = json_response(conn, :bad_request)
    end
  end

  describe "delete/1" do
    test "returns success, if valid id", %{conn: conn} do
      {:ok, %{id: id} = _user} = Users.create(@valid_attrs)

      conn = delete(conn, ~p"/api/users/#{id}")
      %{"data" => %{"id" => id_response}} = json_response(conn, :ok)
      assert to_string(id) == id_response

      conn = get(conn, ~p"/api/users/#{id}")
      assert json_response(conn, :not_found)
    end
  end
end
