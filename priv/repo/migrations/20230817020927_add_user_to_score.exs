defmodule Bytebinder.Repo.Migrations.AddUserToScore do
  use Ecto.Migration

  def change do
    alter table(:scores) do
      add :user_id, references(:users)
    end
  end
end
