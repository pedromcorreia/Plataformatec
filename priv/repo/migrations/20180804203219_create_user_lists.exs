defmodule ToDoList.Repo.Migrations.CreateUserNotes do
  use Ecto.Migration

  def change do
    create table(:user_lists) do
      add :user_id, references(:users, on_delete: :delete_all)
      add :note_id, references(:notes, on_delete: :delete_all)

      timestamps()
    end
  end
end
