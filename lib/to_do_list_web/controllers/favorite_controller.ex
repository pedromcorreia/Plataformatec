defmodule ToDoListWeb.FavoriteController do
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
        |> Map.put(:goals_total, Enum.count(goals))
      end)

    render(conn, "index.html", notes: notes)
  end

  def create(conn, %{"id" => id}) do
    notes = []

      Map.new()
      |> Map.put(:note_id, Map.get(List.first(Task.get_public_note(id)),:id))
      |> Map.put(:user_id, Helpers.current_user(conn))
      |> Task.create_favorite()
    render(conn, "index.html", notes: notes)
  end
end
