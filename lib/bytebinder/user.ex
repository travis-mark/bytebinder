defmodule Bytebinder.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    field :email, :string
    field :name, :string
    field :notes, :string
    field :pronouns, :string

    timestamps()
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:name, :email, :pronouns, :notes])
    |> validate_required([:name, :email])
    |> validate_format(:email, ~r/@/)
  end
end
