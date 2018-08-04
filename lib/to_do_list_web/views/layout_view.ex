defmodule ToDoListWeb.LayoutView do
  use ToDoListWeb, :view


  def get_user(conn, :id) do
    conn
    |> get_user()
    |> Map.get(:id)
  end

  def get_user(conn) do
    conn
    |> Map.get(:assigns)
    |> Map.get(:current_user)
  end
end
