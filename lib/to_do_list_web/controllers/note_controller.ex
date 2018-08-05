defmodule ToDoListWeb.NoteController do
  use ToDoListWeb, :controller

  alias ToDoList.Task
  alias ToDoList.Task.{Note, Goal}
  alias ToDoList.Coherence.Schemas
  alias ToDoListWeb.Helpers

  def index(conn, _params) do
    notes =
      conn
      |> Helpers.get_user_id()
      |> Task.list_notes_by_user()
      |> Enum.map(fn(x) ->
        goals = Task.list_goals_by_note_id(x.id)
        x
        |> Map.put(:goals_done, Enum.count(goals, fn(y) -> y.status == "done" end))
        |> Map.put(:goals_total, Enum.count(goals))
      end)

    render(conn, "index.html", notes: notes)
  end

  def new(conn, _params) do
    changeset = Task.change_note(%Note{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"note" => note_params}) do
    case Task.create_note(Map.merge(note_params, Helpers.get_user_id(conn))) do
      {:ok, note} ->
        conn
        |> put_flash(:info, "Note created successfully.")
        |> redirect(to: note_path(conn, :show, note))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    note = Task.get_note(id)
    if note == nil do conn
    |> send_resp(404, "Not found")
    |> halt()
    end
    if note.user_id == Map.get(Helpers.get_user_id(conn), "user_id") do
      goals = Task.list_goals_by_note_id(note.id)
      user = Schemas.get_user(note.user_id)
      changeset = Task.change_goal(%Goal{})
      render(conn, "show.html", changeset: changeset, note: note, user: user, goals: goals)
    else
      conn
      |> send_resp(404, "Not found")
      |> halt()
    end
  end

  def update(conn, %{"id" => id, "note" => note_params}) do
    note = Task.get_note!(id)

    case Task.update_note(note, note_params) do
      {:ok, note} ->
        conn
        |> put_flash(:info, "Note updated successfully.")
        |> redirect(to: note_path(conn, :show, note))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", note: note, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    note = Task.get_note!(id)
    {:ok, _note} = Task.delete_note(note)

    conn
    |> put_flash(:info, "Note deleted successfully.")
    |> redirect(to: note_path(conn, :index))
  end
end
