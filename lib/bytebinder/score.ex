defmodule Bytebinder.Score do
  use Ecto.Schema
  import Ecto.Changeset

  schema "scores" do
    field :game, :string
    field :game_no, :string
    field :score, :integer
    field :win, :boolean
    field :input, :string

    belongs_to :user, Bytebinder.Accounts.User

    timestamps()
  end

  @doc false
  def changeset(score, attrs) do
    score
    |> cast(attrs, [:input, :score, :win, :game, :game_no, :user_id])
    |> validate_required([:user_id])
  end

  @doc """
  Attempt to classify score based on pasted input from game.
  """
  def classify(input) do
    [&parse_wordle/1, &parse_dordle/1, &parse_octordle/1, &parse_connections/1, &parse_tradle/1]
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
  Parse Dordle score
  """
  def parse_dordle(input) do
    data = Regex.named_captures(~r/(?s)(?<game>[A-Za-z ]*Dordle) (?<game_no>\d+) (?<left>\d)[&](?<right>\d)\/7/, input) |> IO.inspect()
    if data["left"] && data["right"] do
      score = String.to_integer(data["left"]) + String.to_integer(data["right"])
      %{"game" => data["game"], "game_no" => data["game_no"], "score" => Integer.to_string(score), "win" => true}
    else
      nil
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

  @doc """
  Parse Tradle score
  """
  def parse_tradle(input) do
    data = Regex.named_captures(~r/(?s)(?<game>Tradle) #(?<game_no>\d+).*(?<score>\d+)\/6/, input)
    if data do
      data |> Map.put("win", !String.contains?(input, "🟥"))
    end
  end

  @doc """
  Given a game name and number, compute the date of the game.
  """
  def game_date(score) do
    case score.game do
      "Wordle" ->
        {:ok, original_date} = Date.from_iso8601("2021-06-19")
        game_no = String.to_integer(score.game_no)
        Date.add(original_date, game_no)
      "Daily Dordle" ->
        {:ok, original_date} = Date.from_iso8601("2022-01-24")
        game_no = String.to_integer(score.game_no)
        Date.add(original_date, game_no)
      "Daily Octordle" ->
        {:ok, original_date} = Date.from_iso8601("2022-01-24")
        game_no = String.to_integer(score.game_no)
        Date.add(original_date, game_no)
      _ ->
        {:ok, dummy_date} = Date.from_iso8601("2001-01-01")
        dummy_date
    end
  end
end
