defmodule Book.Router do
  use Book.Web, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Book.Auth, repo: Book.Repo
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", Book do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
    resources "/users", UserController
    resources "/sessions", SessionController
    resources "/posts", PostController
  end

  scope "/manage", Book do

  pipe_through [:browser, :authenticate_user]
  resources "/posts", PostController

  end

  # Other scopes may use custom stacks.
  # scope "/api", Book do
  #   pipe_through :api
  # end
end
