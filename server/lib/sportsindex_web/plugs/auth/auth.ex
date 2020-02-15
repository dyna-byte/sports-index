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

  def login(conn, user) do
    conn
    |> G.Plug.sign_in(conn, user)
    |> put_resource(user)
  end

  def put_resource(conn, user) do
    jwt = G.Plug.current_token(conn)

    conn
    |> assign(:current_user, user)
    |> assign(:current_token, jwt)
  end

  def logout(conn) do
    conn
    |> G.Plug.sign_out()
  end

  def refresh(conn) do
    jwt = G.Plug.current_token(conn)

    {:ok, _old_stuff, {new_token, _new_claims}} = G.refresh(jwt)

    new_token
  end
end
