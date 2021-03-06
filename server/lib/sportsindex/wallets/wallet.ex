defmodule Sportsindex.Wallets.Wallet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "wallets" do
    field :value, :integer, default: 0

    belongs_to :user, Sportsindex.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(wallet, attrs) do
    wallet
    |> cast(attrs, [:value])
    |> validate_required([:value])
  end

  def changeset(wallet, attrs, user) do
    wallet
    |> changeset(attrs)
    |> put_assoc(:user, user)
  end
end
