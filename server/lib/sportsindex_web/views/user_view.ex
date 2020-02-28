defmodule SportsindexWeb.UserView do
  use SportsindexWeb, :view
  alias SportsindexWeb.UserView
  alias SportsindexWeb.SessionView

  def render("new.json", %{user: _user, jwt: _token} = params) do
    render(SessionView, "show.json", params)
  end

  def render("index.json", %{users: users}) do
    %{data: render_many(users, UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      name: user.name}
  end
end
