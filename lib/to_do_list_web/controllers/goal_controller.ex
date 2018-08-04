defmodule ToDoListWeb.GoalController do
  use ToDoListWeb, :controller

  alias ToDoList.Task
  alias ToDoList.Task.Goal
  alias ToDoList.Coherence.Schemas

  def index(conn, _params) do
    goals = Task.list_goals()
    render(conn, "index.html", goals: goals)
  end

  def new(conn, _params) do
    changeset = Task.change_goal(%Goal{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"goal" => goal_params}) do
    case Task.create_goal(goal_params) do
      {:ok, goal} ->
        list = Task.get_list!(goal.list_id)
        conn
        |> redirect(to: list_path(conn, :show, list))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    goal = Task.get_goal!(id)
    render(conn, "show.html", goal: goal)
  end

  def edit(conn, %{"id" => id}) do
    goal = Task.get_goal!(id)
    changeset = Task.change_goal(goal)
    render(conn, "edit.html", goal: goal, changeset: changeset)
  end

  def update(conn, %{"id" => id, "goal" => goal_params}) do
    goal = Task.get_goal!(id)

    case Task.update_goal(goal, goal_params) do
      {:ok, goal} ->
        list = Task.get_list!(goal.list_id)
        conn
        |> redirect(to: list_path(conn, :show, list))
      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", goal: goal, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    goal = Task.get_goal!(id)
    list = Task.get_list!(goal.list_id)
    {:ok, _goal} = Task.delete_goal(goal)

    conn
    |> redirect(to: list_path(conn, :show, list))
  end
end
