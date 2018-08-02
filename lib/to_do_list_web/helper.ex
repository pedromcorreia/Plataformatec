defmodule ToDoListWeb.Helpers do

  def get_user_id(conn) do
    %{"user_id" => conn |> Map.get(:assigns) |> Map.get(:current_user) |> Map.get(:id)}
  end
end
