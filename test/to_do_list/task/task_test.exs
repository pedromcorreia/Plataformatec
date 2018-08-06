defmodule ToDoList.TaskTest do
  use ToDoList.DataCase

  alias ToDoList.Task
  alias ToDoList.Coherence.User

  describe "lists" do
    alias ToDoList.Task.Note

    @valid_attrs %{title: "some name", type: "public"}
    @update_attrs %{title: "some updated name", type: "some updated type"}
    @invalid_attrs %{title: nil, type: nil}

    def user_fixture() do
      %User{}
      |> User.changeset( %{name: Faker.Name.name(), email: Faker.Internet.email(), password: "secret", password_confirmation: "secret"})
      |> ToDoList.Repo.insert!
    end

    def note_fixture(attrs \\ %{}) do
      {:ok, note} =
        attrs
        |> Enum.into(Map.put(@valid_attrs, :user_id, Map.get(user_fixture(), :id)))
        |> Task.create_note()

      note
    end

    def note_user_fixture(attrs \\ %{}) do
      user = user_fixture()
      {:ok, note} =
        attrs
        |> Enum.into(Map.put(@valid_attrs, :user_id, Map.get(user, :id)))
        |> Task.create_note()

      %{note: note, user: user}
    end

    test "list_recent_notes/0 returns all notes" do
      note = note_fixture()
      note_created = List.first(Task.list_recent_notes())
      assert note_created.id  == note.id
    end

    test "list_notes_by_user/2 returns all notes" do
      note = note_user_fixture()
      notes = Task.list_notes_by_user(%{"user_id" => Map.get(note, :user).id})
      assert List.first(notes) == List.first(notes)
    end

    test "list_notes_by_user_id/2 returns all notes" do
      note = note_user_fixture()
      notes = Task.list_notes_by_user_id(Map.get(note, :user).id, :all)
      assert List.first(notes) == List.first(notes)
    end

    test "list_notes_by_user_id/2 returns all public notes" do
      note = note_user_fixture()
      notes = Task.list_notes_by_user_id(Map.get(note, :user).id, :public)
      assert List.first(notes) == List.first(notes)
    end

    test "get_note/1 returns the notes with given id" do
      note = note_fixture()
      assert note.id == Task.get_note!(note.id).id
      assert note.id == Task.get_note(note.id).id
      assert "some name" == Task.get_note!(note.id) |> Map.get(:title)
      assert "some name" == Task.get_note(note.id) |> Map.get(:title)
    end

    test "get_public_note/1 returns the public notes with given id" do
      note = note_fixture()
      assert note.id == Task.get_public_note(note.id) |> List.first() |> Map.get(:id)
      assert "some name" == Task.get_public_note(note.id) |> List.first() |> Map.get(:title)
    end

    test "create_note/1 with valid data creates a note" do
      assert {:ok, %Note{} = note} =
        %{}
        |> Enum.into(Map.put(@valid_attrs, :user_id, Map.get(user_fixture(), :id)))
        |> Task.create_note()

      assert note.title == "some name"
      assert note.type == "public"
    end

    test "create_note/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Task.create_note(@invalid_attrs)
    end

    test "update_note/2 with valid data updates the note" do
      note = note_fixture()
      assert {:ok, note} = Task.update_note(note, @update_attrs)
      assert %Note{} = note
      assert note.title == "some updated name"
      assert note.type == "some updated type"
    end

    test "update_note/2 with invalid data returns error changeset" do
      note = note_fixture()
      assert {:error, %Ecto.Changeset{}} = Task.update_note(note, @invalid_attrs)
      assert note.id == Task.get_note!(note.id).id
      assert "some name" == Task.get_note!(note.id) |> Map.get(:title)
    end

    test "delete_note/1 deletes the note" do
      note = note_fixture()
      assert {:ok, %Note{}} = Task.delete_note(note)
      assert_raise Ecto.NoResultsError, fn -> Task.get_note!(note.id) end
    end

    test "change_note/1 returns a note changeset" do
      note = note_fixture()
      assert %Ecto.Changeset{} = Task.change_note(note)
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
        |> Enum.into(Map.put(@valid_attrs, :note_id, Map.get(note_fixture(), :id)))
        |> Task.create_goal()

      goal
    end

    def goal_note_fixture(attrs \\ %{}) do
      note = note_fixture()
      {:ok, goal} =
        attrs
        |> Enum.into(Map.put(@valid_attrs, :note_id, Map.get(note, :id)))
        |> Task.create_goal()

      %{note: note, goal: goal}
    end

    test "list_goals/0 returns all goals" do
      goal = goal_fixture()
      assert Task.list_goals() == [goal]
    end

    test "list_goals_by_note_id/1 returns all goals by note_id" do
      goal = goal_note_fixture() |> Map.get(:goal)
      goal_created = Task.list_goals_by_note_id(Map.get(goal, :note_id)) |> List.first()
      assert goal_created.id == goal |> Map.get(:id)
    end

    test "get_goal!/1 returns the goal with given id" do
      goal = goal_fixture()
      assert Task.get_goal!(goal.id) == goal
    end

    test "create_goal/1 with valid data creates a goal" do
      assert {:ok, %Goal{} = goal} =
        %{}
        |> Enum.into(Map.put(@valid_attrs, :note_id, Map.get(note_fixture(), :id)))
        |> Task.create_goal()

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

  describe "favorite" do

    alias ToDoList.User.Note, as: Favorite

    @valid_attrs %{description: "some description", status: "some status", title: "Some title", type: "public"}

    def favorite_fixture(attrs \\ %{}) do
      user = user_fixture()
      {:ok, note} =
        attrs
        |> Enum.into(Map.put(@valid_attrs, :user_id, Map.get(user, :id)))
        |> Task.create_note()

      %{note_id: note.id, user_id: user.id}
    end


    test "create_favorite/0 create favorite" do
      favorite = favorite_fixture()
      assert {:ok, %Favorite{} = favorite_created} = Task.create_favorite(favorite)
      assert favorite_created.user_id == favorite.user_id
      assert favorite_created.note_id == favorite.note_id
    end

    test "list_favorite_by_user_id/1 list favorite by user_id" do
      favorite = favorite_fixture()
      {:ok, %Favorite{} = favorite_created} = Task.create_favorite(favorite)
      assert favorite_created ==
        Task.list_favorite_by_user_id(%{"user_id" => favorite.user_id}) |> List.first()
      assert favorite_created.user_id == favorite.user_id
      assert favorite_created.note_id == favorite.note_id
    end

    test "get_favorite_by_note_id_and_user_id/2 list favorite by user_id and note_id" do
      favorite = favorite_fixture()
      {:ok, %Favorite{} = favorite_created} = Task.create_favorite(favorite)
      get_favorite = Task.get_favorite_by_note_id_and_user_id(
          favorite.note_id,
          favorite.user_id
        )
      assert favorite_created == get_favorite |> List.first
      
    end

    test "delete_favorite/1 delete favorite" do
      favorite = favorite_fixture()
      {:ok, %Favorite{} = favorite_created} = Task.create_favorite(favorite)
      {:ok, deleted} = Task.delete_favorite(favorite_created)
      assert favorite_created |> Map.get(:id) == deleted |> Map.get(:id)
    end
  end
end
