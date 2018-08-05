defmodule ToDoList.User.Note do
  use Ecto.Schema
  import Ecto.Changeset

  alias ToDoList.Coherence.User
  alias ToDoList.Task.Note

  schema "user_notes" do
    belongs_to(:user, User)
    belongs_to(:note, Note)

    timestamps()
  end

  @doc false
  def changeset(note, attrs) do
    note
    |> cast(attrs, [:user_id, :note_id])
    |> validate_required([:user_id, :note_id])
  end
end
