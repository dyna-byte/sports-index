defmodule Sportsindex.WalletsTest do
  use Sportsindex.DataCase

  alias Sportsindex.Wallets

  describe "wallets" do
    alias Sportsindex.Wallets.Wallet

    @valid_attrs %{currency: "USD", value: 42}
    @invalid_attrs %{currency: "some crap", value: nil}

    def wallet_fixture(attrs \\ %{}) do
      user = insert_user()
      {:ok, wallet} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Wallets.create_wallet(user)

      {wallet, user}
    end

    test "get_user_wallet!/1 returns the user's wallet" do
      {wallet, user} = wallet_fixture()
      wallets = Wallets.get_user_wallets(user)
      assert length(wallets) == 1
      assert Enum.at(wallets, 0).id == wallet.id
    end

    test "create_wallet/1 with valid data creates a wallet" do
      user = insert_user()
      assert {:ok, %Wallet{} = wallet} = Wallets.create_wallet(@valid_attrs, user)
      assert wallet.currency == Map.get(@valid_attrs, :currency)
      assert wallet.value == 42
    end

    test "create_wallet/1 with invalid data returns error changeset" do
      user = insert_user()
      assert {:error, %Ecto.Changeset{}} = Wallets.create_wallet(@invalid_attrs, user)
    end

    test "delete_wallet/1 deletes the wallet" do
      {wallet, _user} = wallet_fixture()
      assert {:ok, %Wallet{}} = Wallets.delete_wallet(wallet)
      assert_raise Ecto.NoResultsError, fn -> Wallets.get_wallet!(wallet.id) end
    end

    test "change_wallet/1 returns a wallet changeset" do
      {wallet, _user} = wallet_fixture()
      assert %Ecto.Changeset{} = Wallets.change_wallet(wallet)
    end
  end
end
