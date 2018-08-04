defmodule ToDoList.Repo.Migrations.CreateUserLists do
  use Ecto.Migration

  def change do
    create table(:user_lists) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :list_id, references(:lists, on_delete: :delete_all)

      timestamps()
    end
  end
end
