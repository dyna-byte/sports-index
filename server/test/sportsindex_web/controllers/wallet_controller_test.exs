defmodule SportsindexWeb.WalletControllerTest do
  use SportsindexWeb.ConnCase

  alias Sportsindex.Wallets
  alias Sportsindex.Wallets.Wallet
  import Logger

  @update_attrs %{
    value: 43
  }

  setup [:create_and_login]

  setup %{conn: conn, user: user} do
    wallet = Wallets.get_user_wallet(user)
    {:ok, conn: put_req_header(conn, "accept", "application/json"), wallet: wallet}
  end

  describe "index" do
    test "get user wallet", %{conn: conn, user: user} do
      conn = get(conn, Routes.wallet_path(conn, :index))
      assert %{ "value" => 0} = json_response(conn, 200)["data"]
    end
  end

  describe "update wallet" do

    test "renders wallet when data is valid", %{conn: conn, wallet: wallet} do
      id = wallet.id
      rconn = put(conn, Routes.wallet_path(conn, :update, wallet), wallet: @update_attrs)
      assert %{"id" => ^id} = json_response(rconn, 200)["data"]

      rconn = get(conn, Routes.wallet_path(conn, :index))

      assert %{
               "id" => id,
               "value" => 43
             } = json_response(rconn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, wallet: wallet} do
      conn = put(conn, Routes.wallet_path(conn, :update, wallet), wallet: %{ value: nil })
      assert json_response(conn, 422)["errors"] != %{}
    end
  end
end
