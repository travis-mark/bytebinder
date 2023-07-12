alias Bytebinder.{Repo,User}

defmodule BytebinderWeb.UserController do
  use BytebinderWeb, :controller

  def index(conn, _params) do
    users = Bytebinder.Repo.all(Bytebinder.User)
    render(conn, :index, users: users)
  end

  def edit(conn, %{"id" => id}) do
    render(conn, :edit, id: id)
  end

  def new(conn, _params) do
    render(conn, :new)
  end

  @spec show(Plug.Conn.t(), map) :: Plug.Conn.t()
  def show(conn, %{"id" => id}) do
    user = Bytebinder.Repo.get(Bytebinder.User, id)
    render(conn, :show, user: user)
  end

  @spec create(Plug.Conn.t(), any) :: Plug.Conn.t()
  def create(conn, %{"user" => user_params}) do
    changeset = User.changeset(%User{}, user_params)

    case Repo.insert(changeset) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User created successfully.")
        |> redirect(to: ~p"/users/")

      {:error, changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def update(conn, %{"id" => id}) do
    render(conn, :show, update: id)
  end

  def delete(conn, %{"id" => id}) do
    render(conn, :show, delete: id)
  end
end

defmodule BytebinderWeb.UserHTML do
  use BytebinderWeb, :html

  embed_templates "users_html/*"
end
