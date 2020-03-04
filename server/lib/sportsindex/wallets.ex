defmodule Sportsindex.Wallets do
  @moduledoc """
  The Wallets context.
  """

  import Ecto.Query, warn: false
  import Ecto
  alias Sportsindex.Repo

  alias Sportsindex.Wallets.Wallet

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
  def get_user_wallet!(id, user), do: assoc(user, :wallet) |> Repo.get!(id)

  def get_user_wallet(user) do
    assoc(user, :wallet)
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
end
