defmodule ToDoListWeb.ListController do
  use ToDoListWeb, :controller

  alias ToDoList.Task
  alias ToDoList.Task.List
  alias ToDoList.Coherence.Schemas
  alias ToDoListWeb.Helpers

  def index(conn, _params) do
    lists = Task.list_lists()
    render(conn, "index.html", lists: lists)
  end

  def new(conn, _params) do
    changeset = Task.change_list(%List{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"list" => list_params}) do
    case Task.create_list(Map.merge(list_params, Helpers.get_user_id(conn))) do
      {:ok, list} ->
        conn
        |> put_flash(:info, "List created successfully.")
        |> redirect(to: list_path(conn, :show, list))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    list = Task.get_list!(id)
    goals = Task.list_goals_by_list_id(list.id)
    user = Schemas.get_user(list.user_id)
    render(conn, "show.html", list: list, user: user, goals: goals)
  end

  def edit(conn, %{"id" => id}) do
    list = Task.get_list!(id)
    changeset = Task.change_list(list)
    render(conn, "edit.html", list: list, changeset: changeset)
  end

  def update(conn, %{"id" => id, "list" => list_params}) do
    list = Task.get_list!(id)

    case Task.update_list(list, list_params) do
      {:ok, list} ->
        conn
        |> put_flash(:info, "List updated successfully.")
        |> redirect(to: list_path(conn, :show, list))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", list: list, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    list = Task.get_list!(id)
    {:ok, _list} = Task.delete_list(list)

    conn
    |> put_flash(:info, "List deleted successfully.")
    |> redirect(to: list_path(conn, :index))
  end
end
