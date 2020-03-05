defmodule Sportsindex.Wallets.Transaction do
  use Ecto.Schema
  import Ecto.Changeset

  schema "transactions" do
    field :amount, :integer
    field :source, :string

    belongs_to :wallet, Sportsindex.Wallets.Wallet

    timestamps()
  end

  def changeset(transaction, attrs, wallet) do
    transaction
    |> changeset(attrs)
    |> put_assoc(:wallet, wallet)
  end

  def changeset(transaction, attrs) do
    transaction
    |> cast(attrs, [:amount, :source])
    |> validate_required([:amount, :source])
    |> transform()
  end

  def transform(changeset) do
    changeset
    |> update_change(:source, &String.upcase/1)
  end
end
