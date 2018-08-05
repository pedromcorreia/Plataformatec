# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     ToDoList.Repo.insert!(%ToDoList.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

ToDoList.Repo.delete_all ToDoList.Coherence.User

ToDoList.Coherence.User.changeset(%ToDoList.Coherence.User{}, %{name: "Test User", email: "testuser@example.com", password: "secret", password_confirmation: "secret"})
|> ToDoList.Repo.insert!

ToDoList.Coherence.User.changeset(%ToDoList.Coherence.User{}, %{name: "basic", email: "basic@mail.com", password: "1234", password_confirmation: "1234"})
|> ToDoList.Repo.insert!

ToDoList.Task.Note.changeset(%ToDoList.Task.Note{}, %{title: "Chocolate cookie", type: "public", user_id: 1})
|> ToDoList.Repo.insert!

ToDoList.Task.Note.changeset(%ToDoList.Task.Note{}, %{title: "How to get away with murder", type: "public", user_id: 1})
|> ToDoList.Repo.insert!

ToDoList.Task.Note.changeset(%ToDoList.Task.Note{}, %{title: "Basic guitar", type: "private", user_id: 1})
|> ToDoList.Repo.insert!

ToDoList.Task.Note.changeset(%ToDoList.Task.Note{}, %{title: "Simple cookie", type: "public", user_id: 2})
|> ToDoList.Repo.insert!

ToDoList.Task.Note.changeset(%ToDoList.Task.Note{}, %{title: "How i meet your mother", type: "public", user_id: 2})
|> ToDoList.Repo.insert!
