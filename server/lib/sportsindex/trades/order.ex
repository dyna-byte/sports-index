defmodule Sportsindex.Trades.Order do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field :price, :integer
    field :quantity, :integer
    field :side, :string

    belongs_to :user, Sportsindex.Accounts.User
    belongs_to :asset, Sportsindex.Assets.Asset

    timestamps()
  end

  def changeset(order, attrs) do
    order
    |> cast(attrs, [:quantity, :price, :side])
    |> validate_required([:quantity, :price, :side])
  end

  def changeset(order, attrs, user, asset) do
    order
    |> changeset(attrs)
    |> put_assoc(:user, user)
    |> put_assoc(:asset, asset)
  end
end
