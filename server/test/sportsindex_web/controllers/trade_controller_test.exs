defmodule SportsindexWeb.TradeControllerTest do
  use SportsindexWeb.ConnCase

  alias Sportsindex.Trades
  alias Sportsindex.Trades.Trade

  @create_attrs %{
    price: 42,
    quantity: 42
  }
  @update_attrs %{
    price: 43,
    quantity: 43
  }
  @invalid_attrs %{price: nil, quantity: nil}

  def fixture(:trade) do
    {:ok, trade} = Trades.create_trade(@create_attrs)
    trade
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all trades", %{conn: conn} do
      conn = get(conn, Routes.trade_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create trade" do
    test "renders trade when data is valid", %{conn: conn} do
      conn = post(conn, Routes.trade_path(conn, :create), trade: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.trade_path(conn, :show, id))

      assert %{
               "id" => id,
               "price" => 42,
               "quantity" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.trade_path(conn, :create), trade: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update trade" do
    setup [:create_trade]

    test "renders trade when data is valid", %{conn: conn, trade: %Trade{id: id} = trade} do
      conn = put(conn, Routes.trade_path(conn, :update, trade), trade: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.trade_path(conn, :show, id))

      assert %{
               "id" => id,
               "price" => 43,
               "quantity" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, trade: trade} do
      conn = put(conn, Routes.trade_path(conn, :update, trade), trade: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete trade" do
    setup [:create_trade]

    test "deletes chosen trade", %{conn: conn, trade: trade} do
      conn = delete(conn, Routes.trade_path(conn, :delete, trade))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.trade_path(conn, :show, trade))
      end
    end
  end

  defp create_trade(_) do
    trade = fixture(:trade)
    {:ok, trade: trade}
  end
end
