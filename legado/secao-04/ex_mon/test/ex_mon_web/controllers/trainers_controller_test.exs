defmodule ExMonWeb.TrainersControllerTest do
  use ExMonWeb.ConnCase

  alias ExMon.Trainer

  describe "show/2" do
    test "when there is a trainer with the given id, returns the trainer", %{conn: conn} do
      params = %{name: "André", password: "123456"}
      {:ok, %Trainer{id: trainer_id}} = ExMon.create_trainer(params)

      response =
        conn
        |> get(Routes.trainers_path(conn, :show, trainer_id))
        |> json_response(:ok)

      assert %{
               "id" => _variable_id,
               "inserted_at" => _variable_data_insert,
               "name" => "André",
               "pokemons" => []
             } = response
    end

    test "when there is an error, returns the error", %{conn: conn} do
      response =
        conn
        |> get(Routes.trainers_path(conn, :show, "1234"))
        |> json_response(:bad_request)

      expected_response = %{"message" => "Invalid ID format!"}

      assert expected_response == response
    end
  end
end
