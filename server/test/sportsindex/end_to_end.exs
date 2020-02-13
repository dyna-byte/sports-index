defmodule Sportsindex.TradesTest do
  use Sportsindex.DataCase

  alias Sportsindex.Trades
  alias Sportsindex.Accounts

  describe "End to End" do
    alias Sportsindex.Trades.Order

    @valid_attrs %{price: 42, quantity: 42, side: "some side"}
    @update_attrs %{price: 43, quantity: 43, side: "some updated side"}
    @invalid_attrs %{price: nil, quantity: nil, side: nil}

    def order_fixture(attrs \\ %{}) do
      {:ok, asset, user} = Sportsindex.Assets.create_asset_with_user(%{ name: "Test" })
      {:ok, order} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Enum.into(%{ asset: asset, user: user})
        |> Trades.create_order(user, asset)

      { order, asset, user}
    end

    test "Creating Orders" do
      { order, asset, user} = order_fixture()
      norder = Trades.get_order!(order.id)
      assert norder.user_id == user.id
      assert norder.asset_id == asset.id
    end
  end
end
