defmodule Sportsindex.Repo.Migrations.CreateWallets do
  use Ecto.Migration

  def change do
    create table(:wallets) do
      add :value, :integer, default: 0
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create unique_index(:wallets, [:user_id])
  end
end
