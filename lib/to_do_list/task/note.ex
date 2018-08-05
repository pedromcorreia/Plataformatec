defmodule ToDoList.Task.Note do
  use Ecto.Schema
  import Ecto.Changeset
  alias ToDoList.Coherence.User


  schema "notes" do
    field :title, :string
    field :type, :string
    belongs_to(:user, User)


    timestamps()
  end

  @doc false
  def changeset(note, attrs) do
    note
    |> cast(attrs, [:title, :type, :user_id])
    |> validate_required([:title, :type, :user_id])
  end
end
