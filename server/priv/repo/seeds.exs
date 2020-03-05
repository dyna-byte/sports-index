# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Sportsindex.Repo.insert!(%Sportsindex.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
alias Sportsindex.Assets

# Seed the database with some assets
[
  "Federer",
  "Nadal",
  "Djakovitch"
]
|> Enum.map(fn name ->
  {:ok, asset, user} = Assets.create_asset_with_user(%{ name: name})
end)
