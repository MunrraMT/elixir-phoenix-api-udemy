defmodule ExMon.Trainer.CreateTest do
  use ExMon.DataCase

  alias ExMon.{Trainer, Repo}
  alias Trainer.Create

  describe "call/1" do
    test "when all params are valid, creates a trainer" do
      params = %{name: "André", password: "123456"}
      count_before = Repo.aggregate(Trainer, :count)
      response = Create.call(params)
      count_after = Repo.aggregate(Trainer, :count)

      assert count_before == 0
      assert {:ok, %Trainer{name: "André"}} = response
      assert count_after == 1
    end

    test "when there are invalid params, returns  the error" do
      params = %{name: "André"}
      count_before = Repo.aggregate(Trainer, :count)
      response = Create.call(params)
      count_after = Repo.aggregate(Trainer, :count)

      assert count_before == 0
      assert {:error, changeset} = response
      assert errors_on(changeset) == %{password: ["can't be blank"]}
      assert count_after == 0
    end
  end
end
