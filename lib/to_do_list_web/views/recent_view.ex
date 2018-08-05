defmodule ToDoListWeb.RecentView do
  use ToDoListWeb, :view
  alias ToDoListWeb.NoteView
  alias ToDoListWeb.FavoriteView

  def show_note(note), do: "recents/" <> to_string(Map.get(note, :id))

  def difference_date(note), do: NoteView.difference_date(note)

  def concatenate_name(name), do: NoteView.concatenate_name(name)

  def is_favorite(note), do: FavoriteView.is_favorite(note)

  def is_private(conn) do
    if conn |> Map.get(:assigns) |> Map.get(:current_user) == nil do
      false
    else
      true
    end
  end
end
