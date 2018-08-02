defmodule ToDoList.Repo.Migrations.CreateGoals do
  use Ecto.Migration

  def change do
    create table(:goals) do
      add :description, :string
      add :status, :string
      add :list_id, references(:lists, on_delete: :nothing)

      timestamps()
    end

    create index(:goals, [:list_id])
  end
end
