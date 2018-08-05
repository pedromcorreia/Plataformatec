defmodule ToDoListWeb.RecentController do
  use ToDoListWeb, :controller

  alias ToDoList.Task
  alias ToDoList.Task.{Note, Goal}
  alias ToDoList.Coherence.Schemas
  alias ToDoListWeb.Helpers

  def index(conn, _params) do
    current_user_id = Helpers.current_user(conn)
    notes =
      Task.list_recent_notes()
      |> Enum.map(fn(x) ->
        is_favorite =
          case Task.get_favorite_by_note_id_and_user_id(x.id, current_user_id) do
            [] -> false
              _ -> true
          end
        goals = Task.list_goals_by_note_id(x.id)
        x
        |> Map.put(:goals_total, Enum.count(goals))
        |> Map.put(:is_favorite, is_favorite)
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
