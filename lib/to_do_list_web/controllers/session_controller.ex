defmodule ToDoListWeb.SessionController do
  use ToDoListWeb, :controller

  alias ToDoListWeb.Auth

  def new(conn, _params) do
    changeset = []#Auth.change_session(%Session{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"session" => session_params}) do
    changeset = []#Auth.change_session(%Session{})
    render(conn, "new.html", changeset: changeset)
  end

  def delete(conn, _) do
    conn
    |> clear_session()
    |> redirect(to: session_path(conn, :new))
  end
end
