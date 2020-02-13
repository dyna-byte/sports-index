defmodule Sportsindex.Trades.Trade do
  use Ecto.Schema
  import Ecto.Changeset

  schema "trades" do
    field :price, :integer
    field :quantity, :integer

    belongs_to :from_order, Sportsindex.Trades.Order, [foreign_key: :from_order_id]
    belongs_to :to_order, Sportsindex.Trades.Order, [foreign_key: :to_order_id]
    belongs_to :user, Sportsindex.Accounts.User
    belongs_to :asset, Sportsindex.Assets.Asset

    timestamps()
  end

  @doc false
  def changeset(trade, attrs) do
    trade
    |> cast(attrs, [:price, :quantity, :user_id, :asset_id, :from_order_id, :to_order_id])
    |> validate_required([:price, :quantity, :user_id, :asset_id, :from_order_id, :to_order_id])
  end
end
