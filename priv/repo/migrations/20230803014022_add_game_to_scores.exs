defmodule Bytebinder.Repo.Migrations.AddGameToScores do
  use Ecto.Migration

  def change do
    alter table(:scores) do
      add :game, :string
      add :game_no, :string
    end
  end
end
