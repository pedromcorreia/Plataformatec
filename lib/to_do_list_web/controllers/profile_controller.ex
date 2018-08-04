defmodule ToDoListWeb.ProfileController do
  use ToDoListWeb, :controller

  alias ToDoList.Task
  alias ToDoList.Task.{List, Goal}
  alias ToDoList.Coherence.{Schemas, User}
  alias ToDoListWeb.Helpers

  def show(conn, %{"id" => id}) do
    case Schemas.get_user(id) do
      %User{} = user ->
        current_user =
          conn
          |> Map.get(:assigns)
          |> Map.get(:current_user)
          |> Map.get(:id)

          list =
            if current_user == id do
              get_list(id)
            else
              get_list(id, :public)
            end

          changeset = Task.change_goal(%Goal{})
          render(conn, "show.html", changeset: changeset, lists: list, user: user)
      nil ->
        conn
        |> send_resp(404, "Not found")
        |> halt()
    end
  end

  defp get_list(id, atom \\ :all) do
    id
    |> Task.list_lists_by_user_id(atom)
    |> Enum.map(fn(x) ->
      goals = Task.list_goals_by_list_id(x.id)
      x
      |> Map.put(:goals_done, Enum.count(goals, fn(y) -> y.status == "done" end))
      |> Map.put(:goals_total, Enum.count(goals))
    end)
  end
end
