defmodule ToDoList.Task do
  @moduledoc """
  The Task context.
  """

  import Ecto.Query, warn: false
  alias ToDoList.Repo

  alias ToDoList.Task.Note
  alias ToDoList.Coherence.User
  alias ToDoList.User.Note, as: Favorite

   @doc false

  def list_recent_notes do
    Note
    |> limit(6)
    |> order_by(:inserted_at)
    |> where(type: "public")
    |> preload(:user)
    |> Repo.all()
  end

  @doc false
  def list_notes_by_user_id(user_id, :public) do
    Note
    |> where([user_id: ^user_id, type: "public"])
    |> limit(6)
    |> order_by(desc: :inserted_at)
    |> Repo.all()
  end

  def list_notes_by_user_id(user_id, _all) do
    Note
    |> where([user_id: ^user_id])
    |> limit(6)
    |> order_by(desc: :inserted_at)
    |> Repo.all()
  end

  @doc false

  def list_notes_by_user(%{"user_id" => user_id}) do
    Note
    |> where(user_id: ^user_id)
    |> preload(:user)
    |> Repo.all()
  end

  @doc """
  Gets a single note.

  Raises `Ecto.NoResultsError` if the Note does not exist.

  ## Examples

      iex> get_note(123)
      %Note{}

      iex> get_note!(456)
      ** (Ecto.NoResultsError)

  """
  def get_note!(id) do
    Note
    |> preload(:user)
    |> Repo.get!(id)
  end

  def get_note(id) do
    Note
    |> preload(:user)
    |> Repo.get(id)
  end

  @doc false
  def get_public_note(id) do
    Note
    |> where([type: "public", id: ^id])
    |> Repo.all()
  end

  @doc """
  Creates a note.

  ## Examples

      iex> create_note(%{field: value})
      {:ok, %Note{}}

      iex> create_note(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_note(attrs \\ %{}) do
    %Note{}
    |> Note.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a note.

  ## Examples

      iex> update_note(note, %{field: new_value})
      {:ok, %Note{}}

      iex> update_note(note, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_note(%Note{} = note, attrs) do
    note
    |> Note.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Note.

  ## Examples

      iex> delete_note(note)
      {:ok, %Note{}}

      iex> delete_note(note)
      {:error, %Ecto.Changeset{}}

  """
  def delete_note(%Note{} = note) do
    Repo.delete(note)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking note changes.

  ## Examples

      iex> change_note(note)
      %Ecto.Changeset{source: %Note{}}

  """
  def change_note(%Note{} = note) do
    Note.changeset(note, %{})
  end

  alias ToDoList.Task.Goal

  @doc """
  Returns the list of goals by note_id.

  ## Examples

      iex> list_goals_by_note_id(4)
      [%Goal{}, ...]

  """

  def list_goals_by_note_id(note_id) do
    Goal
    |> where(note_id: ^note_id)
    |> limit(6)
    |> order_by(desc: :inserted_at)
    |> Repo.all()
  end

  @doc """
  Returns the list of goals.

  ## Examples

      iex> list_goals()
      [%Goal{}, ...]

  """
  def list_goals do
    Repo.all(Goal)
  end

  @doc """
  Gets a single goal.

  Raises `Ecto.NoResultsError` if the Goal does not exist.

  ## Examples

      iex> get_goal!(123)
      %Goal{}

      iex> get_goal!(456)
      ** (Ecto.NoResultsError)

  """
  def get_goal!(id), do: Repo.get!(Goal, id)

  @doc """
  Creates a goal.

  ## Examples

      iex> create_goal(%{field: value})
      {:ok, %Goal{}}

      iex> create_goal(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_goal(attrs \\ %{}) do
    %Goal{}
    |> Goal.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a goal.

  ## Examples

      iex> update_goal(goal, %{field: new_value})
      {:ok, %Goal{}}

      iex> update_goal(goal, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_goal(%Goal{} = goal, attrs) do
    goal
    |> Goal.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Goal.

  ## Examples

      iex> delete_goal(goal)
      {:ok, %Goal{}}

      iex> delete_goal(goal)
      {:error, %Ecto.Changeset{}}

  """
  def delete_goal(%Goal{} = goal) do
    Repo.delete(goal)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking goal changes.

  ## Examples

      iex> change_goal(goal)
      %Ecto.Changeset{source: %Goal{}}

  """
  def change_goal(%Goal{} = goal) do
    Goal.changeset(goal, %{})
  end

  @doc false
  def create_favorite(attrs \\ %{}) do
    %Favorite{}
    |> Favorite.changeset(attrs)
    |> Repo.insert()
  end

  @doc false
  def list_favorite_by_user_id(%{"user_id" => user_id}) do
    Favorite
    |> where([user_id: ^user_id])
    |> limit(6)
    |> order_by(desc: :inserted_at)
    |> Repo.all()
  end

  @doc false
  def get_favorite_by_note_id_and_user_id(note_id, user_id) do
    Favorite
    |> where([note_id: ^note_id, user_id: ^user_id])
    |> Repo.all()
  end

  def delete_favorite(%Favorite{} = favorite) do
    Repo.delete(favorite)
  end
end
