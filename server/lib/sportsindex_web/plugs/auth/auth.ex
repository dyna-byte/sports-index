defmodule SportsindexWeb.Auth do
  import Plug.Conn
  import Phoenix.Controller
  alias SportsindexWeb.Auth.Guardian

  def init(opts) do
    opts
  end

  def call(conn, _opts) do
    current_user = Guardian.Plug.current_resource(conn)
    jwt = Guardian.Plug.current_token(conn)

    conn
    |> assign(:current_user, current_user)
    |> assign(:current_token, jwt)
  end

  def login(conn, user) do
    new_conn = Guardian.Plug.sign_in(conn, user)
    jwt = Guardian.Plug.current_token(new_conn)

    new_conn
    |> assign(:current_user, user)
    |> assign(:current_token, jwt)
  end

  def logout(conn) do
    conn
    |> Guardian.Plug.sign_out()
  end

  def refresh(conn) do
    jwt = Guardian.Plug.current_token(conn)

    {:ok, _old_stuff, {new_token, _new_claims}} = Guardian.refresh(jwt)

    new_token
  end
end
