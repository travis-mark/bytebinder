defmodule Bytebinder.Admin.Game do
  use Ecto.Schema
  import Ecto.Changeset

  schema "games" do
    field :game, :string
    field :game_no, :string
    field :solution, :string
    field :release_date, :date

    timestamps()
  end

  @doc false
  def changeset(game, attrs) do
    game
    |> cast(attrs, [:game, :game_no, :solution, :release_date])
    |> validate_required([:game, :game_no, :solution, :release_date])
  end
end
