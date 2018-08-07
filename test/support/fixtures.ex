defmodule ToDoList.Fixtures do
  alias ToDoList.Repo

  def build(:goal) do
    build(:note)
    %ToDoList.Task.Goal{
      description: "description",
      status: "doing"
    }
  end

  def build(:note) do
    build(:user)
    %ToDoList.Task.Note{
      title: "description",
      type: "doing"
    }
  end

  def build(:user) do
    %ToDoList.Coherence.User{
      name: Faker.Name.name,
      email: Faker.Internet.email,
      password: "some-pwd",
      password_confirmation: "some-pwd"
    }
  end

  def build(fixture_name, attributes) do
    fixture_name |> build() |> struct(attributes)
  end
  def insert!(fixture_name, attributes \\ [], opts \\ [])

  def insert!(fixture_name, attributes, opts) do
    preload = Keyword.get_values(opts, :preload)

    fixture_name
    |> build(attributes)
    |> Repo.insert!(on_conflict: :nothing)
    |> Repo.preload(preload)
  end
end
