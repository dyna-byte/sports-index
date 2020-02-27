defmodule SportsindexWeb.Router do
  use SportsindexWeb, :router
  alias SportsindexWeb.Auth

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :authenticated do
    import Auth, only: [authenticate: 2]
    plug Guardian.Plug.Pipeline, module: SportsindexWeb.Auth.Guardian,
      error_handler: SportsindexWeb.Auth.GuardianErrorHandler
    plug Guardian.Plug.VerifyHeader, realm: "Bearer"
    plug Guardian.Plug.LoadResource, allow_blank: true
    plug Auth
    plug :authenticate
  end

  scope "/", SportsindexWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", SportsindexWeb do
    pipe_through :api

    post "/sessions", SessionController, :create
    post "/users", UserController, :create

    # Authenticated users only
    pipe_through :authenticated
    delete "/sessions", SessionController, :delete
    get "/sessions/refresh", SessionController, :refresh
  end
end
