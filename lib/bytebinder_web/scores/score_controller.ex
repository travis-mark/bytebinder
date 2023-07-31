alias Bytebinder.{Repo,Score,User}

defmodule BytebinderWeb.ScoreController do
  use BytebinderWeb, :controller

  def index(conn, _params) do
    scores = Repo.all(Score)
    render(conn, :index, scores: scores)
  end

  def new(conn, _params) do
    user = Repo.get(User, 1) # TODO: Map to logged in user after auth
    changeset = Score.changeset(%Score{}, %{user: user})
    render(conn, :new, changeset: changeset, user: user)
  end

  def create(conn, %{"score" => score_params}) do
    # TODO: Attempt to extract game, game_no and score from input
    classify = false
    changeset = Score.changeset(%Score{}, score_params)

    case Repo.insert(changeset) do
      {:ok, score} ->
        if classify do
          conn
          |> put_flash(:info, "Score added.")
          |> redirect(to: ~p"/scores/")
        else
          conn
          |> put_flash(:error, "Score created, please add additional details.")
          |> redirect(to: ~p"/scores/#{score.id}/edit")
        end

      {:error, changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def edit(conn, %{"id" => id}) do
    score = Repo.get(Score, id)
    changeset = Score.changeset(score, %{})
    render(conn, :edit, changeset: changeset)
  end
end
