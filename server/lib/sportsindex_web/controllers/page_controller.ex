defmodule SportsindexWeb.PageController do
  use SportsindexWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
