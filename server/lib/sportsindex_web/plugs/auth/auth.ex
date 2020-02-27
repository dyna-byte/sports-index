defmodule SportsindexWeb.Auth do
  import Plug.Conn
  import Phoenix.Controller
  alias SportsindexWeb.Auth.Guardian, as: G

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    current_user = G.Plug.current_resource(conn)

    conn
    |> put_resource(current_user)
  end

  @doc"""
  Add a user to the context and create a token
  """
  def login(conn, user) do
    conn
    |> Guardian.Plug.sign_in(G, user)
    |> put_resource(user)
  end

  def put_resource(conn, user) do
    jwt = G.Plug.current_token(conn)

    conn
    |> assign(:current_user, user)
    |> assign(:current_token, jwt)
  end

  @doc"""
  Revoke the token and remove the user from context
  """
  def logout(conn) do
    conn
    |> G.Plug.sign_out()
  end

  @doc"""
  Verify that a user has been added to the context
  """
  def authenticate(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_status(:forbidden)
      |> put_view(Sling.SessionView)
      |> render("forbidden.json", error: "Not Authenticated")
      |> halt()
    end
  end

  def refresh(conn) do
    jwt = G.Plug.current_token(conn)

    {:ok, _old_stuff, {new_token, _new_claims}} = G.refresh(jwt)

    new_token
  end
end
