defmodule Sportsindex.Repo.Migrations.CreateOrders do
  use Ecto.Migration

  def change do
    create table(:orders) do
      add :quantity, :integer
      add :price, :integer
      add :side, :string
      add :user_id, references(:users, on_delete: :nothing)
      add :asset_id, references(:assets, on_delete: :nothing)

      timestamps()
    end

    create index(:orders, [:user_id])
    create index(:orders, [:asset_id])
    create index(:orders, [:side])
    create index(:orders, [:quantity])
  end
end
