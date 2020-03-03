defmodule Sportsindex.AuthHelpers do
  alias Sportsindex.Accounts

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

end
