defmodule BytebinderWeb.PageController do
  use BytebinderWeb, :controller

  def home(conn, _params) do
    render(conn, :home)
  end
end
