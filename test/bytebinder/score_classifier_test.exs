defmodule Bytebinder.ScoreClassifierTest do
  use ExUnit.Case

  test "Score Classifier" do
    pairs = [
      [
        "Wordle 771 3/6*\r\n\r\n⬛⬛⬛⬛🟩\r\n🟨🟩⬛⬛🟩\r\n🟩🟩🟩🟩🟩",
        %{"game" => "Wordle", "game_no" => "771", "hardmode" => "*", "score" => "3", "win" => true}
      ],
      [
        "Wordle 733 X/6\r\n\r\n🟨⬛⬛⬛⬛\r\n⬛🟩⬛🟨⬛\r\n⬛🟩⬛🟨🟩\r\n⬛🟩🟩🟩🟩\r\n⬛🟩🟩🟩🟩\r\n⬛🟩🟩🟩🟩",
        %{"game" => "Wordle", "game_no" => "733", "hardmode" => "", "score" => "7", "win" => false}
      ],
      [
        "Daily Octordle #553\r\n🔟7️⃣\r\n6️⃣8️⃣\r\n3️⃣5️⃣\r\n9️⃣🕚\r\nScore: 59",
        %{"game" => "Daily Octordle", "game_no" => "553", "score" => "59", "win" => true}
      ],
      [
        "Daily Octordle #501\r\n6️⃣🟥\r\n5️⃣8️⃣\r\n3️⃣🟥\r\n🕐🔟\r\nScore: 73",
        %{"game" => "Daily Octordle", "game_no" => "501", "score" => "73", "win" => false}
      ],
      [
        "Daily Sequence Octordle #563 4️⃣5️⃣ 7️⃣8️⃣ 9️⃣🔟 🕚🕛 Score: 66",
        %{"game" => "Daily Sequence Octordle", "game_no" => "563", "score" => "66", "win" => true}
      ],
      [
        "Connections \nPuzzle #51\n🟨🟨🟨🟨\n🟩🟩🟩🟩\n🟪🟪🟪🟪\n🟦🟦🟦🟦",
        %{"game" => "Connections", "game_no" => "51", "score" => "0", "win" => true}
      ],
      [
        "Connections Puzzle #59 🟦🟦🟩🟦 🟦🟦🟦🟩 🟦🟦🟨🟩 🟦🟦🟪🟩",
        %{"game" => "Connections", "game_no" => "59", "score" => "4", "win" => false}
      ],
      [
        "#Tradle #527 2/6 🟩🟩🟩🟩🟨 🟩🟩🟩🟩🟩 https://oec.world/en/tradle",
        %{"game" => "Tradle", "game_no" => "527", "score" => "2", "win" => true}
      ],
    ]
    for [input, expected] <- pairs do
      output = Bytebinder.Score.classify(input)
      assert output == expected
    end
  end
end
