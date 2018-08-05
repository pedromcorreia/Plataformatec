defmodule ToDoListWeb.RecentController do
  use ToDoListWeb, :controller

  alias ToDoList.Task
  alias ToDoList.Task.{Note, Goal}
  alias ToDoList.Coherence.Schemas
  alias ToDoListWeb.Helpers

  def index(conn, _params) do
    notes =
      Task.list_recent_notes()
      |> Enum.map(fn(x) ->
        goals = Task.list_goals_by_note_id(x.id)
        Map.put(x, :goals_total, Enum.count(goals))
      end)

    render(conn, "index.html", notes: notes)
  end

  def show(conn, %{"id" => id}) do
    case Task.get_public_note(id) do
      [%Note{}] = note ->
        [note] = note
        goals = Task.list_goals_by_note_id(note.id)
        user = Schemas.get_user(note.user_id)
        changeset = Task.change_goal(%Goal{})
        render(conn, "show.html", changeset: changeset, note: note, user: user, goals: goals)
      _ ->
        conn
        |> send_resp(404, "Not found")
        |> halt()
    end
  end
end
