defmodule ToDoListWeb.ProfileView do
  use ToDoListWeb, :view
  alias ToDoListWeb.ListView

  def show_list(list), do: "/lists/" <> to_string(Map.get(list, :id))

  def difference_date(list), do: ListView.difference_date(list)

  def concatenate_name(name), do: ListView.concatenate_name(name)

end
