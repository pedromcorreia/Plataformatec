defmodule ToDoListWeb.NoteControllerTest do
  use ToDoListWeb.ConnCase

  alias ToDoList.Task

  @create_attrs %{title: "some title", type: "some type", user_id: 1}
  @invalid_attrs %{title: nil, type: nil}

  def fixture(:note) do
    {:ok, note} = Task.create_note(@create_attrs)
    note
  end

  describe "index" do
    test "redirect to /", %{conn: conn} do
      conn = get conn, note_path(conn, :index)
      assert redirected_to(conn) == "/"
    end

    test "list all notes", %{conn: conn} do
      conn = conn |> authenticate() |> get(note_path(conn, :index))
      assert html_response(conn, 200) =~ "My To-Do-List"
    end
  end

  describe "new note" do
    test "redirect to /", %{conn: conn} do
        conn = get conn, note_path(conn, :new)
      assert redirected_to(conn) == "/"
    end

    test "renders form", %{conn: conn} do
      conn = conn |> authenticate() |> get(note_path(conn, :new))
      assert html_response(conn, 200) =~ "Create a To-Do-List"
    end
  end

  describe "create note" do
    test "redirect to /", %{conn: conn} do
        conn = get conn, note_path(conn, :create)
      assert redirected_to(conn) == "/"
    end

    test "redirects to show when data is valid", %{conn: conn} do
      conn = conn |> authenticate() |> post(note_path(conn, :create), note: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == note_path(conn, :show, id)
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = conn |> authenticate() |> post(note_path(conn, :create), note: @invalid_attrs)
      assert html_response(conn, 200) =~ "Oops, something went wrong! Please check the errors below."
    end
  end

  describe "delete note" do
    setup [:create_note]

    test "deletes chosen note", %{conn: conn, note: note} do
    conn = conn() |> delete(note_path(conn, :delete, note))
      assert redirected_to(conn) == note_path(conn, :index)
      assert_error_sent 404, fn ->
        get conn, note_path(conn, :show, note)
      end
    end
  end

  defp create_note(conn) do
    user_id =
      %ToDoList.Coherence.User{}
      |> ToDoList.Coherence.User.changeset(%{
        name: Faker.Name.name,
        email: Faker.Internet.email,
        password: "secret",
        password_confirmation: "secret"
      })
      |> ToDoList.Repo.insert!()
      |> Map.get(:id)
    {:ok, note} = Task.create_note(Map.put(@create_attrs, :user_id, user_id))
  end
end
