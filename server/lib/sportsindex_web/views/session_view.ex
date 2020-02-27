defmodule SportsindexWeb.SessionView do
  use SportsindexWeb, :view
  alias SportsindexWeb.UserView

  def render("show.json", %{user: user, jwt: jwt}) do
    %{data: %{
      user: render_one(user, UserView, "user.json"),
      meta: %{
        token: jwt
      }
    }}
  end
end
