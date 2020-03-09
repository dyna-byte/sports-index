defmodule Sportsindex.Wallets do
  @moduledoc """
  The Wallets context.
  """

  import Ecto.Query, warn: false
  import Ecto
  alias Sportsindex.Repo

  alias Sportsindex.Wallets.Wallet
  alias Sportsindex.Accounts.User
  alias Sportsindex.Wallets.Transaction

  @doc """
  Returns the list of wallets.

  ## Examples

      iex> list_wallets()
      [%Wallet{}, ...]

  """
  def list_wallets do
    Repo.all(Wallet)
  end

  @doc """
  Gets a single wallet.

  Raises `Ecto.NoResultsError` if the Wallet does not exist.

  ## Examples

      iex> get_wallet!(123)
      %Wallet{}

      iex> get_wallet!(456)
      ** (Ecto.NoResultsError)

  """
  def get_wallet!(id), do: Repo.get!(Wallet, id) |> Repo.preload(:user)
  def get_user_wallet!(id, user), do: user_wallet(user) |> Repo.get!(id)

  def get_user_wallet(user) do
    user_wallet(user)
    |> Repo.one()
  end

  def create_wallet(attrs, user) do
    %Wallet{}
    |> Wallet.changeset(attrs, user)
    |> Repo.insert()
  end


  @doc """
  Updates a wallet.

  ## Examples

      iex> update_wallet(wallet, %{field: new_value})
      {:ok, %Wallet{}}

      iex> update_wallet(wallet, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_wallet(%Wallet{} = wallet, attrs) do
    wallet
    |> Wallet.changeset(attrs)
    |> Repo.update()
  end

  alias Sportsindex.Wallets.Transaction

  @doc """
  Returns the list of transactions.
  """
  def list_transactions do
    Repo.all(Transaction)
  end

  @doc """
  Gets a single transaction.
  """
  def get_transaction!(id), do: Repo.get!(Transaction, id)

  def get_user_transactions(user = %User{}) do
    q = from t in Transaction,
    join: w in assoc(t, :wallet),
    on: w.user_id == ^user.id,
    order_by: [desc: t.id],
    select: t

    Repo.all(q)
  end

  @doc """
  Creates a transaction.
  """
  def create_transaction(attrs \\ %{}, wallet) do
    %Transaction{}
    |> Transaction.changeset(attrs, wallet)
    |> Repo.insert()
  end

  @doc """
  Updates a transaction.
  """
  def update_transaction(%Transaction{} = transaction, attrs) do
    transaction
    |> Transaction.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a transaction.
  """
  def delete_transaction(%Transaction{} = transaction) do
    Repo.delete(transaction)
  end

  @doc """
  Add amount to a user's wallet
  """
  def add_credit(user = %User{}, amount) when is_integer(amount) do
    Repo.transaction(fn ->
      wallet = get_user_wallet(user)
      {:ok, _} = create_transaction(%{ amount: amount, source: "payment"}, wallet)
      {:ok, wallet} = update_wallet(wallet, %{ value: wallet.value + amount})
      wallet
    end)
  end

  def recalculate_from_transactions(user = %User{}) do
    balance = get_user_transactions(user)
    |> Enum.reduce(0, fn transaction, total -> total + transaction.amount end)

    get_user_wallet(user)
    |> update_wallet(%{ value: balance })
  end

  defp user_wallet(user), do: assoc(user, :wallet)

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking transaction changes.
  """
  def change_transaction(%Transaction{} = transaction) do
    Transaction.changeset(transaction, %{})
  end
end
