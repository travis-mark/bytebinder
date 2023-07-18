defmodule Bytebinder.League do
  use Ecto.Schema
  import Ecto.Changeset

  schema "leagues" do
    field :name, :string

    timestamps()
  end
end
