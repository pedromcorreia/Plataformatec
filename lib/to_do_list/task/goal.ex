defmodule ToDoList.Task.Goal do
  use Ecto.Schema
  import Ecto.Changeset
  alias ToDoList.Task.Note

  schema "goals" do
    field :description, :string
    field :status, :string, default: "doing"
    belongs_to(:note, Note)


    timestamps()
  end

  @doc false
  def changeset(goal, attrs) do
    goal
    |> cast(attrs, [:description, :status, :note_id])
    |> validate_required([:description, :status, :note_id])
  end
end
