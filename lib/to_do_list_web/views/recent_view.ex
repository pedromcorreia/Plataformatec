defmodule ToDoListWeb.RecentView do
  use ToDoListWeb, :view
  alias ToDoListWeb.ListView

  def show_list(list), do: "recents/" <> to_string(Map.get(list, :id))

  def difference_date(list), do: ListView.difference_date(list)

  def concatenate_name(name), do: ListView.concatenate_name(name)
end
