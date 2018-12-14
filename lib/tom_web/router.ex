defmodule TomWeb.Router do
  use TomWeb, :router

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

  scope "/", TomWeb do
    pipe_through :browser

    get "/", PageController, :index
    resources "/projects", ProjectController
    resources "/users", UserController
    resources "/things", ThingController
    resources "/halls", HallController
  end

  # Other scopes may use custom stacks.
  # scope "/api", TomWeb do
  #   pipe_through :api
  # end
end
