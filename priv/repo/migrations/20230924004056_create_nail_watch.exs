defmodule Bytebinder.Repo.Migrations.CreateNailWatch do
  use Ecto.Migration

  def change do
    create table(:nail_watch) do
      add :date, :date
      add :nails, :integer
      add :skin, :integer
      add :blood, :integer
      add :flag, :string

      timestamps()
    end
  end
end
