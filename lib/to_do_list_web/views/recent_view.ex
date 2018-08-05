defmodule ToDoListWeb.RecentView do
  use ToDoListWeb, :view
  alias ToDoListWeb.View

  def show_note(note), do: "recents/" <> to_string(Map.get(note, :id))

  def difference_date(note), do: View.difference_date(note)

  def concatenate_name(name), do: View.concatenate_name(name)
end
