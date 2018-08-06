defmodule ToDoListWeb.PageControllerTest do
  use ToDoListWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get conn, "/"
    assert html_response(conn, 200) =~ "Hello ToDoList!"

    conn = conn |> authenticate() |> get("/")
    assert html_response(conn, 200) =~ "Hello ToDoList!"
  end
end
