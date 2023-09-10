alias Bytebinder.{Repo,Score}

defmodule BytebinderWeb.ScorekeeperController do
  use BytebinderWeb, :controller
  import Ecto.Query

  def index(conn, params) do
    BytebinderWeb.UserAuth.fetch_current_user(conn, {})
    if conn.assigns.current_user do
      my_games = from(s in Score,
        where: s.user_id == ^conn.assigns.current_user.id,
        distinct: s.game,
        select: s.game) |> Repo.all()
      friends = []
      other_games = []
      scores_query = from(s in Score,
        where: s.user_id == ^conn.assigns.current_user.id,
        order_by: [desc: s.game_no])
      scores_query = case Map.get(params, "game") do
        nil -> scores_query
        game -> scores_query |> where([s], s.game == ^game)
      end
      scores = Repo.all(scores_query) |> IO.inspect()
      render(conn, :index,
        my_games: my_games,
        friends: friends,
        other_games: other_games,
        scores: scores)
    else
      redirect(conn, to: ~p"/users/log_in")
    end
  end
end
