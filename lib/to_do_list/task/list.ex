defmodule ToDoList.Task.List do
  use Ecto.Schema
  import Ecto.Changeset
  alias ToDoList.Coherence.User


  schema "lists" do
    field :title, :string
    field :type, :string
    belongs_to(:user, User)


    timestamps()
  end

  @doc false
  def changeset(list, attrs) do
    list
    |> cast(attrs, [:title, :type, :user_id])
    |> validate_required([:title, :type, :user_id])
  end
end
