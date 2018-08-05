defmodule ToDoList.Repo.Migrations.CreateGoals do
  use Ecto.Migration

  def change do
    create table(:goals) do
      add :description, :string
      add :status, :string
      add :note_id, references(:notes, on_delete: :delete_all)

      timestamps()
    end

    create index(:goals, [:note_id])
  end
end
