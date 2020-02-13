defmodule Sportsindex.Repo do
  use Ecto.Repo,
    otp_app: :sportsindex,
    adapter: Ecto.Adapters.Postgres
end
