defmodule BytebinderWeb.UserController do
  use BytebinderWeb, :controller

  def index(conn, _params) do
    render(conn, :index)
  end

  def edit(conn, %{"id" => id}) do
    render(conn, :edit, id: id)
  end

  def new(conn, _params) do
    render(conn, :new)
  end

  @spec show(Plug.Conn.t(), map) :: Plug.Conn.t()
  def show(conn, %{"id" => id}) do
    render(conn, :show, id: id)
  end

  def create(conn, _params) do
    render(conn, :create)
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
