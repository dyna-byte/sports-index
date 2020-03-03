defmodule Sportsindex.Repo.Migrations.AddUniqueEmailToCredential do
  use Ecto.Migration

  def change do
    create unique_index(:credentials, [:email])
  end
end
