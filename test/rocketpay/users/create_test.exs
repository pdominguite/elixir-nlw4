defmodule Rocketpay.Users.CreateTest do
  use Rocketpay.DataCase, async: true

  alias Rocketpay.User
  alias Rocketpay.Users.Create

  describe "call/1" do
    test "when all parameters are valid, return a user" do
      params = %{
        name: "Pedro",
        password: "123456",
        email: "dominguite@example.com",
        age: "23",
        username: "dominguite"
      }

      {:ok, %User{id: user_id}} = Create.call(params)
      user = Repo.get(User, user_id)

      assert %User{name: "Pedro", id: ^user_id} = user
    end

    test "when there are invalid parameters, return an error" do
      params = %{
        name: "Pedro",
        email: "dominguite@example.com",
        age: "10",
        username: "dominguite"
      }

      {:error, changeset} = Create.call(params)

      expected_response = %{
        age: ["must be greater than or equal to 18"],
        password: ["can't be blank"]
      }

      assert errors_on(changeset) == expected_response
    end
  end
end
