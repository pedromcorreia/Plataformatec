defmodule ToDoList.Task.List do
  use Ecto.Schema
  import Ecto.Changeset


  schema "lists" do
    field :name, :string
    field :type, :string

    timestamps()
  end

  @doc false
  def changeset(list, attrs) do
    list
    |> cast(attrs, [:name, :type])
    |> validate_required([:name, :type])
  end
end
