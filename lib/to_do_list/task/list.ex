defmodule ToDoList.Task.List do
  use Ecto.Schema
  import Ecto.Changeset


  schema "lists" do
    field :title, :string
    field :type, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(list, attrs) do
    list
    |> cast(attrs, [:title, :type, :user_id])
    |> validate_required([:title, :type, :user_id])
  end
end
