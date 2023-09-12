defmodule Bytebinder.Repo.Migrations.DropGames do
  use Ecto.Migration

  def change do
    drop table(:games)
  end
end
