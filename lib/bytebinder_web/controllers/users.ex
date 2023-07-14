alias Bytebinder.{Repo,User}

defmodule BytebinderWeb.UserController do
  use BytebinderWeb, :controller

  def index(conn, _params) do
    users = Repo.all(User)
    render(conn, :index, users: users)
  end

  def show(conn, %{"id" => id}) do
    user = Repo.get(User, id)
    render(conn, :show, user: user)
  end

  def new(conn, _params) do
    changeset = User.changeset(%User{}, %{})
    render(conn, :new, changeset: changeset)
  end

  def edit(conn, %{"id" => id}) do
    user = Repo.get(User, id)
    changeset = User.changeset(user, %{})
    render(conn, :edit, changeset: changeset)
  end

  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: ~p"/users/")

      {:error, changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Repo.get(User, id)
    changeset = User.changeset(user, user_params)
    case Repo.update(changeset) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: ~p"/users/")

      {:error, changeset} ->
        render(conn, :edit, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Repo.get(User, id)
    changeset = User.changeset(user, %{})
    case Repo.delete(changeset) do
      {:ok, _user} ->
        conn
        |> put_flash(:info, "User deleted successfully.")
        |> redirect(to: ~p"/users/")

      {:error, changeset} ->
        render(conn, :edit, changeset: changeset)
    end
  end
end

defmodule BytebinderWeb.UserHTML do
  use BytebinderWeb, :html

  embed_templates "users_html/*"
end
