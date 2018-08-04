defmodule ToDoList.User.List do
  use Ecto.Schema
  import Ecto.Changeset

  alias ToDoList.Coherence.User
  alias ToDoList.Task.List

  schema "user_lists" do
    belongs_to(:user_id, User)
    belongs_to(:list_id, List)

    timestamps()
  end

  @doc false
  def changeset(list, attrs) do
    list
    |> cast(attrs, [
      :user_id,
      :list_id
    ])
    |> validate_required([
      :user_id,
      :list_id
    ])
  end
end
