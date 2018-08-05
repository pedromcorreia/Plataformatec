defmodule ToDoListWeb.FavoriteView do
  use ToDoListWeb, :view
  alias ToDoListWeb.NoteView

  alias ToDoListWeb.RecentView

  def show_note(note), do: RecentView.show_note(note)

  def difference_date(note), do: NoteView.difference_date(note)

  def concatenate_name(name), do: NoteView.concatenate_name(name)

  def is_favorite(note) do
    IO.inspect note
    "A"
  end
end
