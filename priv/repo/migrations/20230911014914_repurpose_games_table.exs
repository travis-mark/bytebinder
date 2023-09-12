defmodule :"Elixir.Bytebinder.Repo.Migrations.RepurposeGamesTable" do
  use Ecto.Migration

  def change do
    alter table(:games) do
      remove :game_no
      remove :solution
      add :url, :string
    end
  end
end
