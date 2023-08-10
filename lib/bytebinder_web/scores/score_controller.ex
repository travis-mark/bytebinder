alias Bytebinder.{Repo,Score,User}

defmodule BytebinderWeb.ScoreController do
  use BytebinderWeb, :controller
  import Ecto.Query

  def index(conn, %{"game" => game}) do
    scores = from(s in Score, where: s.game == ^game, order_by: [desc: s.game_no]) |> Repo.all()
    render(conn, :index, scores: scores)
  end

  def index(conn, _params) do
    scores = from(s in Score, order_by: [desc: s.inserted_at]) |> Repo.all()
    render(conn, :index, scores: scores)
  end

  def new(conn, _params) do
    user = Repo.get(User, 1) # TODO: Map to logged in user after auth
    changeset = Score.changeset(%Score{}, %{user: user})
    render(conn, :new, changeset: changeset, user: user)
  end

  def create(conn, %{"score" => score_params}) do
    data = Map.merge(score_params, Score.classify(score_params["input"]) || %{})
    changeset = Score.changeset(%Score{},  data)
    case Repo.insert(changeset) do
      {:ok, score} ->
        if data["score"] do
          conn
          |> put_flash(:info, "#{Score.format(score)} added.")
          |> redirect(to: ~p"/scores/")
        else
          conn
          |> put_flash(:info, "#{Score.format(score)} started, please add additional details.")
          |> redirect(to: ~p"/scores/#{score.id}/edit")
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
        |> redirect(to: ~p"/scores/")

      {:error, changeset} ->
        render(conn, :edit, changeset: changeset)
    end
  end
end
