alias Bytebinder.{Repo,User}

defmodule Bytebinder.League do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, only: [from: 2]

  schema "leagues" do
    field :name, :string

    timestamps()

    many_to_many :users, Bytebinder.User,
      join_through: Bytebinder.UserLeague,
      on_replace: :delete,
      on_delete: :delete_all
  end

  def changeset(league, attrs) do
    user_ids = attrs["user_ids"] || []
    users = from(u in User, where: u.id in ^user_ids)
      |> Repo.all()
    league
      |> cast(attrs, [:name])
      |> put_assoc(:users, users)
      |> validate_required([:name])
  end
end
