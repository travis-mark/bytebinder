# defmodule Bytebinder.User do
#   use Ecto.Schema
#   import Ecto.Changeset

#   # TODO: Friends
#   schema "users" do
#     field :email, :string
#     field :name, :string
#     field :notes, :string
#     field :pronouns, :string

#     timestamps()

#     many_to_many :leagues, Bytebinder.League, join_through: Bytebinder.UserLeague
#   end

#   @doc false
#   def changeset(user, attrs) do
#     user
#     |> cast(attrs, [:name, :email, :pronouns, :notes])
#     |> validate_required([:name, :email])
#     |> validate_format(:email, ~r/@/)
#   end
# end
