defmodule Bytebinder.Score do
  use Ecto.Schema
  import Ecto.Changeset

  schema "scores" do
    belongs_to :user, Bytebinder.User
    field :score, :integer
    field :win, :boolean
    field :input, :string

    timestamps()
  end

  @doc false
  def changeset(score, attrs) do
    score
    |> cast(attrs, [:input, :score, :win])
  end
end
