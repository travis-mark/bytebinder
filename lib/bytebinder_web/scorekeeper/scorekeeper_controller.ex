defmodule BytebinderWeb.ScorekeeperController do
  use BytebinderWeb, :controller

  def index(conn, _params) do
    render(conn, :index)
  end
end
