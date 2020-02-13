use Mix.Config

# Configure your database
config :sportsindex, Sportsindex.Repo,
  username: "postgres",
  password: "postgres",
  database: "sportsindex_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :sportsindex, SportsindexWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn
