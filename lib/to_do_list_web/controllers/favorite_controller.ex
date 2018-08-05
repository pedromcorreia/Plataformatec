defmodule ToDoListWeb.FavoriteController do
  use ToDoListWeb, :controller

  alias ToDoList.Task
  alias ToDoList.Task.{Note, Goal}
  alias ToDoList.Coherence.Schemas
  alias ToDoListWeb.Helpers

  def index(conn, _params) do
    favorites =
      conn
      |> Helpers.get_user_id()
      |> Task.list_favorite_by_user_id()
      |> Enum.map(fn(x) ->
        note =
          x
          |> Map.get(:note_id)
          |> Task.get_note!()

          total =
            note
            |> Map.get(:id)
            |> Task.list_goals_by_note_id()
            |> Enum.count()
            note
            |> Map.put(:goals_total, total)
      end)
    render(conn, "index.html", favorites: favorites)
  end

  def create(conn, %{"id" => id}) do
    Map.new()
    |> Map.put(:note_id, Map.get(List.first(Task.get_public_note(id)),:id))
    |> Map.put(:user_id, Helpers.current_user(conn))
    |> Task.create_favorite()

    index(conn, id)
  end

  def delete(conn, %{"id" => id}) do
    user_id = Helpers.current_user(conn)

    id
    |> Task.get_public_note()
    |> List.first()
    |> Map.get(:id)
    |> Task.get_favorite_by_note_id_and_user_id(user_id)
    |> List.first()
    |> Task.delete_favorite()

    index(conn, id)
  end
end
