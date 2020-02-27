defmodule SportsindexWeb.SessionController do
  use SportsindexWeb, :controller

  alias Sportsindex.Accounts
  alias SportsindexWeb.Auth
  alias Sportsindex.Accounts.User

  action_fallback SportsindexWeb.FallbackController

  def create(conn, %{"email" => email, "password" => password}) do

    # If token already exists, revoke it
    if conn.assigns.current_user do
      Auth.logout(conn)
    end

    with {:ok, %User{} = user} <- Accounts.get_user_by_credential(email, password) do
      conn = conn
      |> Auth.login(user)

      conn
      |> put_status(:created)
      |> render("show.json", user: user, jwt: conn.assigns.current_token)
    end
  end

  def refresh(conn) do
    jwt = Auth.refresh(conn)
    user = conn.assigns.current_user

    conn
    |> render("show.json", user: user, jwt: jwt)
  end

  def delete(conn) do
    conn
    |> Auth.logout()
  end
end
