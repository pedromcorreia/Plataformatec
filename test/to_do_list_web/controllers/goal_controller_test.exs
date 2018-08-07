defmodule ToDoListWeb.GoalControllerTest do
  use ToDoListWeb.ConnCase

  alias ToDoList.Task

  @create_attrs %{description: "some description", status: "some status", note_id: 1}
  @invalid_attrs %{description: nil, status: nil}

  def fixture(:goal) do
    {:ok, goal} = Task.create_goal(@create_attrs)
    goal
  end

  describe "create goal" do

    test "redirects to show when data is valid", %{conn: conn} do
      note_id = insert!(:note) |> Map.get(:id)
      goal = %{description: "some description", status: "some status", note_id: note_id}
      conn = conn |> authenticate() |> post(goal_path(conn, :create), goal: goal)

      assert %{id: _id} = redirected_params(conn)
      assert redirected_to(conn) == "/notes/#{note_id}"
    end
  end

  describe "update goal" do
    setup [:create_goal]

    test "renders errors when data is invalid", %{conn: conn, goal: goal} do
      conn = conn() |> authenticate() |>  put(goal_path(conn, :update, goal), goal: @invalid_attrs)
      assert_error_sent 404, fn ->
        get conn, goal_path(conn, :update, goal)
      end
    end
  end

  defp create_goal(_) do
    goal = insert!(:goal)
    {:ok, goal: goal}
  end
end
