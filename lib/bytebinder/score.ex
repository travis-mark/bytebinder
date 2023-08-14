defmodule Bytebinder.Score do
  use Ecto.Schema
  import Ecto.Changeset

  schema "scores" do
    field :game, :string
    field :game_no, :string
    field :score, :integer
    field :win, :boolean
    field :input, :string

    timestamps()
  end

  @doc false
  def changeset(score, attrs) do
    score
    |> cast(attrs, [:input, :score, :win, :game, :game_no])
  end

  @doc """
  Attempt to classify score based on pasted input from game.
  """
  def classify(input) do
    [&parse_wordle/1, &parse_octordle/1, &parse_connections/1]
    |> Enum.find_value(nil, fn f -> f.(input) end)
  end

  @doc """
  Format score (name and number) for display.
  """
  def format(score) do
    "#{score.game} ##{score.game_no}"
  end

  @doc """
  Parse Wordle score
  """
  def parse_wordle(input) do
    data = Regex.named_captures(~r/(?s)(?<game>Wordle) (?<game_no>\d+) (?<score>\w)\/6(?<hardmode>[*]?)/, input)
    case data["score"] do
      nil -> nil
      s when s in ["1", "2", "3", "4", "5", "6"] -> data |> Map.put("win", true)
      "X" -> data |> Map.put("win", false) |> Map.put("score", "7")
    end
  end

  @doc """
  Parse Octordle score
  """
  def parse_octordle(input) do
    data = Regex.named_captures(~r/(?s)(?<game>[A-Za-z ]*Octordle) #(?<game_no>\d+).*Score[:] (?<score>\d+)/, input)
    if data do
      data |> Map.put("win", !String.contains?(input, "🟥"))
    end
  end

  @doc """
  Parse Connections score
  """
  def parse_connections(input) do
    data = Regex.named_captures(~r/(?s)(?<game>Connections).*Puzzle #(?<game_no>\d+)/, input)
    if data do
      score = Regex.scan(~r/(?s)[🟨🟩🟪🟦]+/, input)
        |> Enum.map(fn match -> hd(match) end)
        |> Enum.count(fn line -> line != "🟨🟨🟨🟨" && line != "🟩🟩🟩🟩" && line != "🟪🟪🟪🟪" && line != "🟦🟦🟦🟦" end)
      data
        |> Map.put("score", Integer.to_string(score))
        |> Map.put("win", score < 4)
    end
  end
end
