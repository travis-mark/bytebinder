defmodule Bytebinder.ScoreDateTest do
  use ExUnit.Case

  test "Score Date" do
    pairs = [
      [
        %{:game => "Wordle", :game_no => "814"},
        ~D[2023-09-11]
      ],
      [
        %{:game => "Daily Octordle", :game_no => "595"},
        ~D[2023-09-11]
      ],
    ]
    for [input, expected] <- pairs do
      output = Bytebinder.Score.game_date(input)
      assert output == expected
    end
  end
end
