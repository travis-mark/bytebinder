defmodule Bytebinder.ScoreClassifierTest do
  use ExUnit.Case

  test "Score Classifier" do
    pairs = [
      [
        "Wordle 771 3/6*\r\n\r\n⬛⬛⬛⬛🟩\r\n🟨🟩⬛⬛🟩\r\n🟩🟩🟩🟩🟩",
        %{"game" => "Wordle", "game_no" => "771", "hardmode" => "*", "score" => "3"}
      ],
      [
        "Daily Octordle #553\r\n🔟7️⃣\r\n6️⃣8️⃣\r\n3️⃣5️⃣\r\n9️⃣🕚\r\nScore: 59",
        %{"game" => "Daily Octordle", "game_no" => "553", "score" => "59"}
      ],
      [
        "Connections \nPuzzle #51\n🟨🟨🟨🟨\n🟩🟩🟩🟩\n🟪🟪🟪🟪\n🟦🟦🟦🟦",
        %{"game" => "Connections", "game_no" => "51"}
      ],
    ]
    for [input, expected] <- pairs do
      output = Bytebinder.Score.classify(input)
      assert output == expected
    end
  end
end
