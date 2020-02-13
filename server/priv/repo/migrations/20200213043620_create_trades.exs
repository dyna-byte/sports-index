defmodule Sportsindex.Repo.Migrations.CreateTrades do
  use Ecto.Migration

  def change do
    create table(:trades) do
      add :price, :integer
      add :quantity, :integer
      add :asset_id, references(:assets, on_delete: :nothing)
      add :from_order_id, references(:orders, on_delete: :nothing)
      add :to_order_id, references(:orders, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:trades, [:asset_id])
    create index(:trades, [:from_order_id])
    create index(:trades, [:to_order_id])
    create index(:trades, [:user_id])
  end
end
