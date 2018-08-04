defmodule ToDoList.Task.Goal do
  use Ecto.Schema
  import Ecto.Changeset
  alias ToDoList.Task.List

  schema "goals" do
    field :description, :string
    field :status, :string, default: "doing"
    belongs_to(:list, List)


    timestamps()
  end

  @doc false
  def changeset(goal, attrs) do
    goal
    |> cast(attrs, [:description, :status, :list_id])
    |> validate_required([:description, :status, :list_id])
  end
end
