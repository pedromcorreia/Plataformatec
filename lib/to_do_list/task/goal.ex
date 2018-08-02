defmodule ToDoList.Task.Goal do
  use Ecto.Schema
  import Ecto.Changeset


  schema "goals" do
    field :description, :string
    field :status, :string, default: "doing"
    field :list_id, :id

    timestamps()
  end

  @doc false
  def changeset(goal, attrs) do
    goal
    |> cast(attrs, [:description, :status, :list_id])
    |> validate_required([:description, :status, :list_id])
  end
end
