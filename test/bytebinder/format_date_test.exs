defmodule Bytebinder.FormatDateTest do
  use ExUnit.Case

  test "Date Format" do
    pairs = [
      [~N[2023-07-16 21:46:19], "16-Jul-2023 21:46"],
      [~N[2023-07-16 22:08:50], "16-Jul-2023 22:08"],
      [~N[1984-10-07 00:00:00], "7-Oct-1984 0:00"],
    ]
    for [input, expected] <- pairs do
      output = Bytebinder.format_date(input)
      assert output == expected
    end
  end
end
