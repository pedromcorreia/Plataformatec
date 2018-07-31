defmodule ToDoList.Auth.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias ToDoList.Auth.User
  alias Ecto.Changeset
  alias Comeonin.Bcrypt

  schema "users" do
    field :email, :string
    field :password_hash, :string
    field :username, :string

    field(:password, :string, virtual: true)


    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:username, :email])
    |> validate_required([:username, :email], max: 255)
    |> validate_format(:email, ~r/^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,}$/ui)
  end

  @doc false
  def password_changeset(user, attrs) do
    user
    |> changeset(attrs)
    |> cast(attrs, [:password])
    |> validate_required([:password])
    |> hash_password()
  end

  defp hash_password(%Changeset{changes: %{password: pass}} = changeset) do
    changeset
    |> put_change(:password_hash, Comeonin.Bcrypt.hashpwsalt(pass))
    |> delete_change(:password)
  end

  defp hash_password(changeset) do
    changeset
  end
end
