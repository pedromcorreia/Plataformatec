defmodule ToDoListWeb.RecentController do
  use ToDoListWeb, :controller

  alias ToDoList.Task
  alias ToDoList.Task.{List, Goal}
  alias ToDoList.Coherence.Schemas
  alias ToDoListWeb.Helpers

  def index(conn, _params) do
    lists =
      Task.list_recent_lists()
      |> Enum.map(fn(x) ->
        goals = Task.list_goals_by_list_id(x.id)
        Map.put(x, :goals_total, Enum.count(goals))
      end)

    render(conn, "index.html", lists: lists)
  end

  def show(conn, %{"id" => id}) do
    case Task.get_public_list(id) do
      [%List{}] = list ->
        [list] = list
        goals = Task.list_goals_by_list_id(list.id)
        user = Schemas.get_user(list.user_id)
        changeset = Task.change_goal(%Goal{})
        render(conn, "show.html", changeset: changeset, list: list, user: user, goals: goals)
      _ ->
        conn
        |> send_resp(404, "Not found")
        |> halt()
    end
  end
end
