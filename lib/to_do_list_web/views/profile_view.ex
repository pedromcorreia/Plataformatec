defmodule ToDoListWeb.ProfileView do
  use ToDoListWeb, :view
  alias ToDoListWeb.NoteView

  def show_note(note), do: "/recents/" <> to_string(Map.get(note, :id))

  def difference_date(note), do: NoteView.difference_date(note)

  def concatenate_name(name), do: NoteView.concatenate_name(name)

end
