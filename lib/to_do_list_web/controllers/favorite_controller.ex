defmodule ToDoListWeb.FavoriteController do
  use ToDoListWeb, :controller

  alias ToDoList.Task
  alias ToDoList.Task.{List, Goal}
  alias ToDoList.Coherence.Schemas
  alias ToDoListWeb.Helpers

  def index(conn, _params) do
    lists =
      conn
      |> Helpers.get_user_id()
      |> Task.list_lists_by_user()
      |> Enum.map(fn(x) ->
        goals = Task.list_goals_by_list_id(x.id)
        x
        |> Map.put(:goals_total, Enum.count(goals))
      end)

    render(conn, "index.html", lists: lists)
  end
end
