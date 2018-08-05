defmodule ToDoListWeb.Helpers do

  def get_user_id(conn) do
    %{"user_id" => conn |> Map.get(:assigns) |> Map.get(:current_user) |> Map.get(:id)}
  end

  def current_user(conn) do
    conn
    |> Map.get(:assigns)
    |> Map.get(:current_user)
    |> Map.get(:id)
  end

  def get_user(conn) do
    conn
    |> Map.get(:assigns)
    |> Map.get(:current_user)
  end
end
