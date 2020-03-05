defmodule Sportsindex.WalletsTest do
  use Sportsindex.DataCase

  alias Sportsindex.Wallets

  describe "wallets" do
    alias Sportsindex.Wallets.Wallet

    @valid_attrs %{value: 42}
    @invalid_attrs %{value: "wrong"}

    def wallet_fixture(attrs \\ %{}) do
      user = insert_user()
      {:ok, wallet} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Wallets.create_wallet(user)

      {wallet, user}
    end

    test "get_user_wallets/1 returns the user's wallet" do
      {wallet, user} = wallet_fixture()
      user_wallet = Wallets.get_user_wallet(user)
      assert user_wallet.id == wallet.id
    end

    test "get_user_wallet!/1 returns the user's wallet" do
      {wallet, user} = wallet_fixture()
      user_wallet = Wallets.get_user_wallet!(wallet.id, user)
      assert wallet.id == user_wallet.id
    end

    test "get_user_wallet!/1 fails if user is not the owner" do
      {wallet, _user} = wallet_fixture()
      other_user = insert_user(%{ email: "other@test.com" })
      assert_raise Ecto.NoResultsError, fn -> Wallets.get_user_wallet!(wallet.id, other_user) end
    end

    test "create_wallet/1 with valid data creates a wallet" do
      user = insert_user()
      assert {:ok, %Wallet{} = wallet} = Wallets.create_wallet(@valid_attrs, user)
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

  describe "transactions" do
    alias Sportsindex.Wallets.Transaction

    @valid_attrs %{amount: 42, source: "some source"}
    @update_attrs %{amount: 43, source: "some updated source"}
    @invalid_attrs %{amount: nil, source: nil}

    def transaction_fixture(attrs \\ %{}) do
      {:ok, transaction} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Wallets.create_transaction()

      transaction
    end

    test "list_transactions/0 returns all transactions" do
      transaction = transaction_fixture()
      assert Wallets.list_transactions() == [transaction]
    end

    test "get_transaction!/1 returns the transaction with given id" do
      transaction = transaction_fixture()
      assert Wallets.get_transaction!(transaction.id) == transaction
    end

    test "create_transaction/1 with valid data creates a transaction" do
      assert {:ok, %Transaction{} = transaction} = Wallets.create_transaction(@valid_attrs)
      assert transaction.amount == 42
      assert transaction.source == "some source"
    end

    test "create_transaction/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Wallets.create_transaction(@invalid_attrs)
    end

    test "update_transaction/2 with valid data updates the transaction" do
      transaction = transaction_fixture()
      assert {:ok, %Transaction{} = transaction} = Wallets.update_transaction(transaction, @update_attrs)
      assert transaction.amount == 43
      assert transaction.source == "some updated source"
    end

    test "update_transaction/2 with invalid data returns error changeset" do
      transaction = transaction_fixture()
      assert {:error, %Ecto.Changeset{}} = Wallets.update_transaction(transaction, @invalid_attrs)
      assert transaction == Wallets.get_transaction!(transaction.id)
    end

    test "delete_transaction/1 deletes the transaction" do
      transaction = transaction_fixture()
      assert {:ok, %Transaction{}} = Wallets.delete_transaction(transaction)
      assert_raise Ecto.NoResultsError, fn -> Wallets.get_transaction!(transaction.id) end
    end

    test "change_transaction/1 returns a transaction changeset" do
      transaction = transaction_fixture()
      assert %Ecto.Changeset{} = Wallets.change_transaction(transaction)
    end
  end
end
