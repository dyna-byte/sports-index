defmodule Sportsindex.Wallets.Wallet do
  use Ecto.Schema
  import Ecto.Changeset

  schema "wallets" do
    field :currency, :string
    field :value, :integer

    belongs_to :user, Sportsindex.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(wallet, attrs) do
    wallet
    |> cast(attrs, [:currency, :value])
    |> validate_required([:currency, :value])
    |> validate_changeset()
  end

  def changeset(wallet, attrs, user) do
    wallet
    |> changeset(attrs)
    |> put_assoc(:user, user)
  end

  def validate_changeset(changeset) do
    changeset
    |> update_change(:currency, &String.upcase/1)
    |> validate_currency()
  end

  def validate_currency(changeset) do
    changeset
    |> validate_inclusion(:currency, ["GBP", "EUR", "USD", "BTC"])
  end
end
