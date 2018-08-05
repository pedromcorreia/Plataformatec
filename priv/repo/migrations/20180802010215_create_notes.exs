defmodule ToDoList.Repo.Migrations.CreateNotes do
  use Ecto.Migration

  def change do
    create table(:notes) do
      add :title, :string
      add :type, :string
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end

    create index(:notes, [:user_id])
  end
end
