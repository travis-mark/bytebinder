defmodule Bytebinder.League do
  use Ecto.Schema
  import Ecto.Changeset

  schema "leagues" do
    field :name, :string

    timestamps()

    many_to_many :users, Bytebinder.User, join_through: Bytebinder.UserLeague
  end

  def changeset(league, attrs) do
    league
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
