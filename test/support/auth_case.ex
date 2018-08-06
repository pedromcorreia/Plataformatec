defmodule SimulatorWeb.AuthCase do
  @moduledoc """
  """
  def authenticate(conn)

  def authenticate(%Plug.Conn{} = conn) do
    authenticate(Faker.Name.name(), Faker.Internet.email(), conn)
  end

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
