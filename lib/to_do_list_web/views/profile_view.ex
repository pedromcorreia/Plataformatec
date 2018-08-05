defmodule ToDoListWeb.ProfileView do
  use ToDoListWeb, :view
  alias ToDoListWeb.Note

  def show_note(note), do: "/recents/" <> to_string(Map.get(note, :id))

  def difference_date(note), do: Note.difference_date(note)

  def concatenate_name(name), do: Note.concatenate_name(name)

end
