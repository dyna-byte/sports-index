defmodule SportsindexWeb.SessionController do
  use SportsindexWeb, :controller

  alias Sportsindex.Accounts
  alias SportsindexWeb.Auth
  alias Sportsindex.Accounts.User

  action_fallback SportsindexWeb.FallbackController

  def create(conn, %{"email" => email, "password" => password}) do

    # If token already exists, revoke it
    if Map.get(conn.assigns, :current_user, nil) do
      Auth.logout(conn)
    end

    with {:ok, %User{} = user} <- Accounts.get_user_by_credential(email, password) do
      conn = conn
      |> Auth.login(user)

      conn
      |> put_status(:created)
      |> render("show.json", user: user, jwt: conn.assigns.current_token)
    else
      {:error, message} ->
        conn
        |> put_status(:unauthorized)
        |> render("error.json", message: message)
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
