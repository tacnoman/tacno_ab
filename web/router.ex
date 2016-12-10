defmodule TacnoAb.Router do
  use TacnoAb.Web, :router

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

  scope "/api", TacnoAb do
    pipe_through :browser

    get "/create", PageController, :create
    get "/sort/:name/:side", PageController, :sort
    get "/sort/:name", PageController, :sort
  end

  scope "/", TacnoAb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", TacnoAb do
  #   pipe_through :api
  # end
end
