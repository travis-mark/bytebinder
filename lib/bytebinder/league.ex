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
      on_replace: :delete
  end

  def changeset(league, attrs) do
    user_ids = attrs["user_ids"] || []
    query = from(u in User, where: u.id in ^user_ids)
    users = Repo.all(query)
    league
    |> Repo.preload(:users)
    |> cast(attrs, [:name])
    |> put_assoc(:users, users)
    |> validate_required([:name])
  end
end
