defmodule Bytebinder.Repo.Migrations.DropOldUsersTable do
  use Ecto.Migration

  def change do
    alter table(:scores) do
      remove :user_id
    end

    drop table(:user_leagues)
    drop table(:users)
  end
end
