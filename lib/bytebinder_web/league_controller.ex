alias Bytebinder.{Repo,League,User}

defmodule BytebinderWeb.LeagueController do
  use BytebinderWeb, :controller

  def index(conn, _params) do
    leagues = Repo.all(League)
    render(conn, :index, leagues: leagues)
  end

  def show(conn, %{"id" => id}) do
    league = Repo.get(League, id) |> Repo.preload(:users)
    render(conn, :show, league: league)
  end

  def new(conn, _params) do
    changeset = League.changeset(%League{}, %{})
    render(conn, :new, changeset: changeset)
  end

  def edit(conn, %{"id" => id}) do
    league = Repo.get(League, id) |> Repo.preload(:users)
    users = Repo.all(User)
    selected_user_ids = league.users |> Enum.map(&Map.get(&1, :id))
    changeset = League.changeset(league, %{})
    render(conn, :edit, changeset: changeset, users: users, selected_user_ids: selected_user_ids)
  end

  def create(conn, %{"league" => league_params}) do
    changeset = League.changeset(%League{}, league_params)

    case Repo.insert(changeset) do
      {:ok, _league} ->
        conn
        |> put_flash(:info, "League created successfully.")
        |> redirect(to: ~p"/leagues/")

      {:error, changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end

  def update(conn, %{"id" => id, "league" => league_params}) do
    league = Repo.get(League, id) |> Repo.preload(:users)
    changeset = League.changeset(league, league_params)
    case Repo.update(changeset) do
      {:ok, _league} ->
        conn
        |> put_flash(:info, "League updated successfully.")
        |> redirect(to: ~p"/leagues/")

      {:error, changeset} ->
        render(conn, :edit, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    league = Repo.get(League, id) |> Repo.preload(:users)
    changeset = League.changeset(league, %{})
    case Repo.delete(changeset) do
      {:ok, _league} ->
        conn
        |> put_flash(:info, "League deleted successfully.")
        |> redirect(to: ~p"/leagues/")

      {:error, changeset} ->
        render(conn, :edit, changeset: changeset)
    end
  end
end
