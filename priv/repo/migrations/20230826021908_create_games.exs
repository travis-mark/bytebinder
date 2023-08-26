defmodule Bytebinder.Repo.Migrations.CreateGames do
  use Ecto.Migration

  def change do
    create table(:games) do
      add :game, :string
      add :game_no, :string
      add :solution, :string
      add :release_date, :date

      timestamps()
    end
  end
end
