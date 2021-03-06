# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :sportsindex,
  ecto_repos: [Sportsindex.Repo]

# Configures the endpoint
config :sportsindex, SportsindexWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "8+H2RB2Sm4QtYUfJvAjY4deLIC7uxiPhonySG9MdUoejbekivTwL9PBjwx1d5yTI",
  render_errors: [view: SportsindexWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Sportsindex.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Guardian configuration
config :sportsindex, SportsindexWeb.Auth.Guardian,
       issuer: "sportsindex",
       secret_key: "tH9MC7pjgNhkFClYALPaD/neaMmRok0KeMzuwRwtcmR0tFFnzZsVJ7KkBKE+kujg"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
