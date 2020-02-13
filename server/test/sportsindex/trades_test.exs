defmodule Sportsindex.TradesTest do
  use Sportsindex.DataCase

  alias Sportsindex.Trades

  describe "orders" do
    alias Sportsindex.Trades.Order

    @valid_attrs %{price: 42, quantity: 42, side: "some side"}
    @update_attrs %{price: 43, quantity: 43, side: "some updated side"}
    @invalid_attrs %{price: nil, quantity: nil, side: nil}

    def order_fixture(attrs \\ %{}) do
      {:ok, order} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Trades.create_order()

      order
    end

    test "list_orders/0 returns all orders" do
      order = order_fixture()
      assert Trades.list_orders() == [order]
    end

    test "get_order!/1 returns the order with given id" do
      order = order_fixture()
      assert Trades.get_order!(order.id) == order
    end

    test "create_order/1 with valid data creates a order" do
      assert {:ok, %Order{} = order} = Trades.create_order(@valid_attrs)
      assert order.price == 42
      assert order.quantity == 42
      assert order.side == "some side"
    end

    test "create_order/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Trades.create_order(@invalid_attrs)
    end

    test "update_order/2 with valid data updates the order" do
      order = order_fixture()
      assert {:ok, %Order{} = order} = Trades.update_order(order, @update_attrs)
      assert order.price == 43
      assert order.quantity == 43
      assert order.side == "some updated side"
    end

    test "update_order/2 with invalid data returns error changeset" do
      order = order_fixture()
      assert {:error, %Ecto.Changeset{}} = Trades.update_order(order, @invalid_attrs)
      assert order == Trades.get_order!(order.id)
    end

    test "delete_order/1 deletes the order" do
      order = order_fixture()
      assert {:ok, %Order{}} = Trades.delete_order(order)
      assert_raise Ecto.NoResultsError, fn -> Trades.get_order!(order.id) end
    end

    test "change_order/1 returns a order changeset" do
      order = order_fixture()
      assert %Ecto.Changeset{} = Trades.change_order(order)
    end
  end
end
