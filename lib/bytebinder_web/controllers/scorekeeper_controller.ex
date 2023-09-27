alias Bytebinder.{Repo,Score}
alias Bytebinder.Accounts.User

defmodule BytebinderWeb.ScorekeeperController do
  use BytebinderWeb, :controller
  import Ecto.Query

  def index(conn, params) do
    BytebinderWeb.UserAuth.fetch_current_user(conn, {})
    if conn.assigns.current_user do
      my_games = from(s in Score,
        where: s.user_id == ^conn.assigns.current_user.id,
        where: not is_nil(s.game),
        distinct: s.game,
        select: s.game) |> Repo.all()
      friends = from(u in User) |> Repo.all()
      other_games = []
      scores_query = from(s in Score,
        where: s.user_id == ^conn.assigns.current_user.id)
      scores_query = case Map.get(params, "game") do
        nil -> scores_query
          |> order_by([s], desc: s.inserted_at)
        game -> scores_query
          |> where([s], s.game == ^game)
          |> order_by([s], desc: s.game_no)
      end
      scores = Repo.all(scores_query)
        |> Enum.map(fn score -> Map.put(score, :game_date, Score.game_date(score)) end)
      render(conn, :index,
        my_games: my_games,
        friends: friends,
        other_games: other_games,
        scores: scores)
    else
      redirect(conn, to: ~p"/users/log_in")
    end
  end

    def new(conn, _params) do
    BytebinderWeb.UserAuth.fetch_current_user(conn, {})
    if conn.assigns.current_user do
      changeset = Score.changeset(%Score{}, %{})
      render(conn, :new, changeset: changeset)
    else
      redirect(conn, to: ~p"/users/log_in")
    end
  end

  def create(conn, %{"score" => score_params}) do
    BytebinderWeb.UserAuth.fetch_current_user(conn, {})
    data = score_params
    |> Map.merge(Score.classify(score_params["input"]) || %{})
    |> Map.merge(%{"user_id" => conn.assigns.current_user.id})
    changeset = Score.changeset(%Score{},  data)
    case Repo.insert(changeset) do
      {:ok, score} ->
        if data["score"] && data["game"] do
          conn
          |> put_flash(:info, "#{Score.format(score)} added.")
          |> redirect(to: ~p"/scorekeeper/?game=#{data["game"]}")
        else
          conn
          |> put_flash(:info, "Score started, please add additional details.")
          |> redirect(to: ~p"/scorekeeper/#{score.id}/edit")
        end

      {:error, changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

    def show(conn, %{"id" => id}) do
    score = Repo.get(Score, id)
    changeset = Score.changeset(score, %{})
    render(conn, :show, changeset: changeset)
  end

  def edit(conn, %{"id" => id}) do
    score = Repo.get(Score, id)
    changeset = Score.changeset(score, %{})
    render(conn, :edit, changeset: changeset)
  end

  def update(conn, %{"id" => id, "score" => score_params}) do
    score = Repo.get(Score, id)
    changeset = Score.changeset(score, score_params)
    case Repo.update(changeset) do
      {:ok, score} ->
        conn
        |> put_flash(:info, "#{Score.format(score)} updated.")
        |> redirect(to: ~p"/scorekeeper/")

      {:error, changeset} ->
        render(conn, :edit, changeset: changeset)
    end
  end
end
