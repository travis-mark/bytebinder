defmodule Bytebinder.Repo.Migrations.CreateUserLeagues do
  use Ecto.Migration

  def change do
    create table(:user_leagues) do
      add :user_id, references(:users)
      add :league_id, references(:leagues)
    end

    create unique_index(:user_leagues, [:user_id, :league_id])
  end
end
