defmodule Sportsindex.Assets.Asset do
  use Ecto.Schema
  import Ecto.Changeset

  schema "assets" do
    field :issued, :integer, default: 0
    field :name, :string

    belongs_to :user, Sportsindex.Accounts.User
    has_many :orders, Sportsindex.Trades.Order

    timestamps()
  end

  @doc false
  def changeset(asset, attrs) do
    asset
    |> cast(attrs, [:name, :issued, :user_id])
    |> validate_required([:name, :user_id])
  end
end
