defmodule BytebinderWeb.LeagueController do
  use BytebinderWeb, :controller

  def index(conn, _params) do
    render(conn, :index)
  end
end

defmodule BytebinderWeb.LeagueHTML do
  use BytebinderWeb, :html

  embed_templates "leagues_html/*"
end
