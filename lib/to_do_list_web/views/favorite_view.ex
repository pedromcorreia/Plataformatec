defmodule ToDoListWeb.FavoriteView do
  use ToDoListWeb, :view
  alias ToDoListWeb.ListView

  def show_list(list), do: ListView.show_list(list)

  def difference_date(list), do: ListView.difference_date(list)

  def concatenate_name(name), do: ListView.concatenate_name(name)
end
