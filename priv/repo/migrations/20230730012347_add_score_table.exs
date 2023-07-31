defmodule Bytebinder.Repo.Migrations.AddScoreTable do
  use Ecto.Migration

  def change do
    create table(:scores) do
      add :user_id, references(:users)
      add :score, :integer
      add :win, :boolean
      add :input, :string

      timestamps()
    end
  end
end
