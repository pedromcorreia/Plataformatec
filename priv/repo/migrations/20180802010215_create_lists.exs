defmodule ToDoList.Repo.Migrations.CreateLists do
  use Ecto.Migration

  def change do
    create table(:lists) do
      add :title, :string
      add :type, :string
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:lists, [:user_id])
  end
end
