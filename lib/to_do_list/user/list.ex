defmodule ToDoList.User.Note do
  use Ecto.Schema
  import Ecto.Changeset

  alias ToDoList.Coherence.User
  alias ToDoList.Task.Note

  schema "user_notes" do
    belongs_to(:user_id, User)
    belongs_to(:note_id, Note)

    timestamps()
  end

  @doc false
  def changeset(note, attrs) do
    Note
    |> cast(attrs, [
      :user_id,
      :note_id
    ])
    |> validate_required([
      :user_id,
      :note_id
    ])
  end
end
