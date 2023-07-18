defmodule Bytebinder.Repo.Migrations.AddLeagues do
  use Ecto.Migration

  def change do
      create table(:leagues) do
        add :name, :string

        timestamps()
      end
  end
end
