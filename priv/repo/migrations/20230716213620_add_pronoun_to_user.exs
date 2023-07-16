defmodule Bytebinder.Repo.Migrations.AddPronounToUser do
  use Ecto.Migration

  def change do
    alter table(:users) do
      add :pronouns, :string
    end
  end
end
