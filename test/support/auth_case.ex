defmodule SimulatorWeb.AuthCase do
  @moduledoc """
  This module have authentication helpers to integrate with Coherence lib.

  Some controllers have public and protected actions, and the following methods will help test them.

  Examples:

  test "GET / and redirect to /sessions/new when not authenticated", %{conn: conn} do
  conn = get(conn, "/")
  assert redirected_to(conn) == session_path(conn, :new)
  end

  test "GET / when authenticated", %{conn: conn} do
  conn = "testuser" |> authenticate(conn) |> get("/")
  assert html_response(conn, 200) =~ "Hello, Admin."
  end

  test "GET / when authenticated", %{conn: conn} do
  conn = conn |> authenticate() |> get("/")
  assert html_response(conn, 200) =~ "Hello, Admin."
  end
  """
  def authenticate(conn)

  def authenticate(%Plug.Conn{} = conn) do
    authenticate(Faker.Name.name(), Faker.Internet.email(), conn)
  end

  # def authenticate(%Plug.Conn{} = conn, [role: "operator"] = opts) do
  #  authenticate("testuseroperator", conn, opts)
  # end


  def authenticate(name, email, %Plug.Conn{} = conn) do

     %ToDoList.Coherence.User{}
      |> ToDoList.Coherence.User.changeset(%{
        name: name,
        email: email,
        password: "secret",
        password_confirmation: "secret"
      })
      |> ToDoList.Repo.insert!()
    |> assign_user(conn)
  end

  def assign_user(%ToDoList.Coherence.User{} = user, %Plug.Conn{} = conn) do
    Plug.Conn.assign(conn, :current_user, user)
  end
end
