defmodule Bytebinder.Score do
  use Ecto.Schema

  schema "scores" do
    belongs_to :user, Bytebinder.User
    field :score, :integer
    field :win, :boolean
    field :input, :string

    timestamps()
  end
end
