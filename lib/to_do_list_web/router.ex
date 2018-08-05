defmodule ToDoListWeb.Router do
  use ToDoListWeb, :router

  use Coherence.Router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session
  end

  pipeline :protected do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug Coherence.Authentication.Session, protected: true
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :browser
    coherence_routes()
  end

  scope "/" do
    pipe_through :protected
    coherence_routes :protected
  end

  scope "/", ToDoListWeb do
    pipe_through :browser

    resources("/sessions", SessionController, only: [:new, :create])
    resources "/recents", RecentController, only: [:index]
      get "/", PageController, :index
  end

  scope "/", ToDoListWeb do
    pipe_through :protected

    resources "/notes", NoteController, except: [:edit]
    resources "/goals", GoalController, only: [:create, :update, :delete]
    resources "/favorites", FavoriteController, only: [:index, :create, :delete]
    resources "/recents", RecentController, only: [:index, :show]
    resources "/profiles", ProfileController
  end
end
