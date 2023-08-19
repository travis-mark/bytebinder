alias Bytebinder.{Repo,Score}

defmodule BytebinderWeb.ScoreController do
  use BytebinderWeb, :controller
  import Ecto.Query

  def index(conn, %{"game" => game}) do
    BytebinderWeb.UserAuth.fetch_current_user(conn, {})
    if conn.assigns.current_user do
      scores = from(s in Score,
        where: s.user_id == ^conn.assigns.current_user.id,
        where: s.game == ^game,
        order_by: [desc: s.game_no]) |> Repo.all()
      render(conn, :index, scores: scores)
    else
      redirect(conn, to: ~p"/users/log_in")
    end
  end

  def index(conn, _params) do
    BytebinderWeb.UserAuth.fetch_current_user(conn, {})
    if conn.assigns.current_user do
      scores = from(s in Score,
        where: s.user_id == ^conn.assigns.current_user.id,
        order_by: [desc: s.inserted_at]) |> Repo.all()
      render(conn, :index, scores: scores)
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
        if data["score"] do
          conn
          |> put_flash(:info, "#{Score.format(score)} added.")
          |> redirect(to: ~p"/scores/")
        else
          conn
          |> put_flash(:info, "Score started, please add additional details.")
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
