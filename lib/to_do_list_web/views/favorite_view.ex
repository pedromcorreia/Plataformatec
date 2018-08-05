defmodule ToDoListWeb.FavoriteView do
  use ToDoListWeb, :view
  alias ToDoListWeb.ListView

  alias ToDoListWeb.RecentView

  def show_list(list), do: RecentView.show_list(list)

  def difference_date(list), do: ListView.difference_date(list)

  def concatenate_name(name), do: ListView.concatenate_name(name)
end
