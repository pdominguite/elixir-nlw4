defmodule RocketpayWeb.AccountsControllerTest do
  use RocketpayWeb.ConnCase, async: true

  alias Rocketpay.{Account, User}

  describe "deposit/2" do
    setup %{conn: conn} do
      params = %{
        name: "Pedro",
        password: "123456",
        email: "dominguite@example.com",
        age: "23",
        username: "dominguite"
      }

      {:ok, %User{account: %Account{id: account_id}}} = Rocketpay.create_user(params)

      # Adicionando o header de autenticação no formato username:password encodado em base64
      conn = put_req_header(conn, "authorization", "Basic YmFuYW5hOm5hbmljYQ==")

      {:ok, conn: conn, account_id: account_id}
    end

    test "when all params are valid, deposit!", %{conn: conn, account_id: account_id} do
      params = %{"value" => "50.00"}

      response =
        conn
        |> post(Routes.accounts_path(conn, :deposit, account_id, params))
        |> json_response(:ok)

      assert %{
        "message" => "Succesfully updated account balance",
        "account" => %{
          "balance" => "50.00",
          "id" => _id
        }
      } = response
    end

    test "when there are invalid params, return an error", %{conn: conn, account_id: account_id} do
      params = %{"value" => "banana"}

      response =
        conn
        |> post(Routes.accounts_path(conn, :deposit, account_id, params))
        |> json_response(400)

      assert %{"message" => "Invalid deposit value!"} = response
    end

  end

end
