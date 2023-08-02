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

  @doc """
  Attempt to classify score based on pasted input from game.
  """
  def classify(input) do
    [
      ~r/Wordle (?<game_no>\d+) (?<score>\w)\/6(?<hardmode>[*]?)/,
      ~r/(?s)Daily Octordle #(?<game_no>\d+).*Score[:] (?<score>\d+)/,
      ~r/(?s)Connections.*Puzzle #(?<game_no>\d+)/ # D'oh no score
    ]
    |> Enum.find_value(nil, fn regex -> Regex.named_captures(regex, input) end)
  end
end
