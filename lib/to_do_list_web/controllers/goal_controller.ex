defmodule ToDoListWeb.GoalController do
  use ToDoListWeb, :controller

  alias ToDoList.Task
  alias ToDoList.Task.Goal
  alias ToDoList.Coherence.Schemas

  def create(conn, %{"goal" => goal_params}) do
    case Task.create_goal(goal_params) do
      {:ok, goal} ->
        note = Task.get_note!(goal.note_id)
        conn
        |> redirect(to: note_path(conn, :show, note))
      {:error, %Ecto.Changeset{} = _changeset} ->
        conn
        |> send_resp(404, "Not found")
        |> halt()
    end
  end

  def update(conn, %{"id" => id, "goal" => goal_params}) do
    goal = Task.get_goal!(id)

    case Task.update_goal(goal, goal_params) do
      {:ok, goal} ->
        note = Task.get_note!(goal.note_id)
        conn
        |> redirect(to: note_path(conn, :show, note))
      {:error, %Ecto.Changeset{} = _changeset} ->
        conn
        |> send_resp(404, "Not found")
        |> halt()
    end
  end

  def update(conn, %{"id" => id, "status" => status}) do
    goal = Task.get_goal!(id)
    goal_params =
      if status == "done" do
        %{status: "doing"}
      else
        %{status: "done"}
      end
    case Task.update_goal(goal, goal_params) do
      {:ok, goal} ->
        note = Task.get_note!(goal.note_id)
        conn
        |> redirect(to: note_path(conn, :show, note))
      {:error, %Ecto.Changeset{} = _changeset} ->
        conn
        |> send_resp(404, "Not found")
        |> halt()
    end
  end

  def update(conn, %{"id" => id, "description" => description}) do
    goal = Task.get_goal!(id)
    goal_params =
      Map.new()
      |> Map.put(:description, List.first(Map.values(description)))
    case Task.update_goal(goal, goal_params) do
      {:ok, goal} ->
        note = Task.get_note!(goal.note_id)
        conn
        |> redirect(to: note_path(conn, :show, note))
      {:error, %Ecto.Changeset{} = _changeset} ->
        conn
        |> send_resp(404, "Not found")
        |> halt()
    end
  end

  def delete(conn, %{"id" => id}) do
    goal = Task.get_goal!(id)
    note = Task.get_note!(goal.note_id)
    {:ok, _goal} = Task.delete_goal(goal)

    conn
    |> redirect(to: note_path(conn, :show, note))
  end
end
