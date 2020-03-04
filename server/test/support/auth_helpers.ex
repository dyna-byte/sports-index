defmodule Sportsindex.AuthHelpers do
  alias Sportsindex.Accounts

  def create_and_login(%{conn: conn}) do
    user = insert_user()
    conn = login_as(conn, user)

    {:ok, conn: conn, user: user}
  end

  def insert_user(attrs \\ %{}) do
    {:ok, user} = attrs
      |> Enum.into(%{
        name: "test_user",
        password: "password1",
        email: "test_user@test.com"
      })
      |> Accounts.create_user_creds()

    user
  end

  def login_as(conn, user) do
    SportsindexWeb.Auth.login(conn, user)
  end
end
