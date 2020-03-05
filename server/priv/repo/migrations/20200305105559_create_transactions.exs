defmodule Sportsindex.Repo.Migrations.CreateTransactions do
  use Ecto.Migration

  def change do
    create table(:transactions) do
      add :amount, :integer, null: false
      add :source, :string, null: false
      add :wallet_id, references(:wallets, on_delete: :nothing), null: false

      timestamps()
    end

    create index(:transactions, [:wallet_id])
  end
end
