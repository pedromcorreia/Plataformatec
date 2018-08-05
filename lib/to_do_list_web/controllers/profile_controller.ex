defmodule ToDoListWeb.ProfileController do
  use ToDoListWeb, :controller

  alias ToDoList.Task
  alias ToDoList.Task.{Note, Goal}
  alias ToDoList.Coherence.{Schemas, User}
  alias ToDoListWeb.Helpers

  def show(conn, %{"id" => id}) do
    case Schemas.get_user(id) do
      %User{} = user ->
        note =
          if Helpers.current_user(conn) == id do
            get_note(id)
          else
            get_note(id, :public)
          end

          changeset = Task.change_goal(%Goal{})
          render(conn, "show.html", changeset: changeset, notes: note, user: user)
      nil ->
        conn
        |> send_resp(404, "Not found")
        |> halt()
    end
  end

  defp get_note(id, atom \\ :all) do
    id
    |> Task.list_notes_by_user_id(atom)
    |> Enum.map(fn(x) ->
      goals = Task.list_goals_by_note_id(x.id)
      x
      |> Map.put(:goals_done, Enum.count(goals, fn(y) -> y.status == "done" end))
      |> Map.put(:goals_total, Enum.count(goals))
    end)
  end
end
