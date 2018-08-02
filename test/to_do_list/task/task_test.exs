defmodule ToDoList.TaskTest do
  use ToDoList.DataCase

  alias ToDoList.Task

  describe "lists" do
    alias ToDoList.Task.List

    @valid_attrs %{name: "some name", type: "some type"}
    @update_attrs %{name: "some updated name", type: "some updated type"}
    @invalid_attrs %{name: nil, type: nil}

    def list_fixture(attrs \\ %{}) do
      {:ok, list} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Task.create_list()

      list
    end

    test "list_lists/0 returns all lists" do
      list = list_fixture()
      assert Task.list_lists() == [list]
    end

    test "get_list!/1 returns the list with given id" do
      list = list_fixture()
      assert Task.get_list!(list.id) == list
    end

    test "create_list/1 with valid data creates a list" do
      assert {:ok, %List{} = list} = Task.create_list(@valid_attrs)
      assert list.name == "some name"
      assert list.type == "some type"
    end

    test "create_list/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Task.create_list(@invalid_attrs)
    end

    test "update_list/2 with valid data updates the list" do
      list = list_fixture()
      assert {:ok, list} = Task.update_list(list, @update_attrs)
      assert %List{} = list
      assert list.name == "some updated name"
      assert list.type == "some updated type"
    end

    test "update_list/2 with invalid data returns error changeset" do
      list = list_fixture()
      assert {:error, %Ecto.Changeset{}} = Task.update_list(list, @invalid_attrs)
      assert list == Task.get_list!(list.id)
    end

    test "delete_list/1 deletes the list" do
      list = list_fixture()
      assert {:ok, %List{}} = Task.delete_list(list)
      assert_raise Ecto.NoResultsError, fn -> Task.get_list!(list.id) end
    end

    test "change_list/1 returns a list changeset" do
      list = list_fixture()
      assert %Ecto.Changeset{} = Task.change_list(list)
    end
  end

  describe "lists" do
    alias ToDoList.Task.List

    @valid_attrs %{title: "some title", type: "some type"}
    @update_attrs %{title: "some updated title", type: "some updated type"}
    @invalid_attrs %{title: nil, type: nil}

    def list_fixture(attrs \\ %{}) do
      {:ok, list} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Task.create_list()

      list
    end

    test "list_lists/0 returns all lists" do
      list = list_fixture()
      assert Task.list_lists() == [list]
    end

    test "get_list!/1 returns the list with given id" do
      list = list_fixture()
      assert Task.get_list!(list.id) == list
    end

    test "create_list/1 with valid data creates a list" do
      assert {:ok, %List{} = list} = Task.create_list(@valid_attrs)
      assert list.title == "some title"
      assert list.type == "some type"
    end

    test "create_list/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Task.create_list(@invalid_attrs)
    end

    test "update_list/2 with valid data updates the list" do
      list = list_fixture()
      assert {:ok, list} = Task.update_list(list, @update_attrs)
      assert %List{} = list
      assert list.title == "some updated title"
      assert list.type == "some updated type"
    end

    test "update_list/2 with invalid data returns error changeset" do
      list = list_fixture()
      assert {:error, %Ecto.Changeset{}} = Task.update_list(list, @invalid_attrs)
      assert list == Task.get_list!(list.id)
    end

    test "delete_list/1 deletes the list" do
      list = list_fixture()
      assert {:ok, %List{}} = Task.delete_list(list)
      assert_raise Ecto.NoResultsError, fn -> Task.get_list!(list.id) end
    end

    test "change_list/1 returns a list changeset" do
      list = list_fixture()
      assert %Ecto.Changeset{} = Task.change_list(list)
    end
  end

  describe "goals" do
    alias ToDoList.Task.Goal

    @valid_attrs %{description: "some description", status: "some status"}
    @update_attrs %{description: "some updated description", status: "some updated status"}
    @invalid_attrs %{description: nil, status: nil}

    def goal_fixture(attrs \\ %{}) do
      {:ok, goal} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Task.create_goal()

      goal
    end

    test "list_goals/0 returns all goals" do
      goal = goal_fixture()
      assert Task.list_goals() == [goal]
    end

    test "get_goal!/1 returns the goal with given id" do
      goal = goal_fixture()
      assert Task.get_goal!(goal.id) == goal
    end

    test "create_goal/1 with valid data creates a goal" do
      assert {:ok, %Goal{} = goal} = Task.create_goal(@valid_attrs)
      assert goal.description == "some description"
      assert goal.status == "some status"
    end

    test "create_goal/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Task.create_goal(@invalid_attrs)
    end

    test "update_goal/2 with valid data updates the goal" do
      goal = goal_fixture()
      assert {:ok, goal} = Task.update_goal(goal, @update_attrs)
      assert %Goal{} = goal
      assert goal.description == "some updated description"
      assert goal.status == "some updated status"
    end

    test "update_goal/2 with invalid data returns error changeset" do
      goal = goal_fixture()
      assert {:error, %Ecto.Changeset{}} = Task.update_goal(goal, @invalid_attrs)
      assert goal == Task.get_goal!(goal.id)
    end

    test "delete_goal/1 deletes the goal" do
      goal = goal_fixture()
      assert {:ok, %Goal{}} = Task.delete_goal(goal)
      assert_raise Ecto.NoResultsError, fn -> Task.get_goal!(goal.id) end
    end

    test "change_goal/1 returns a goal changeset" do
      goal = goal_fixture()
      assert %Ecto.Changeset{} = Task.change_goal(goal)
    end
  end
end
