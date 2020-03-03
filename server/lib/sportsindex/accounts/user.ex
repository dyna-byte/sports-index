defmodule Sportsindex.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset

  alias Sportsindex.Wallets.Wallet

  schema "users" do
    field :name, :string

    has_many :wallets, Wallet

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
