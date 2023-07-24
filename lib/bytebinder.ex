defmodule Bytebinder do
  @moduledoc """
  Bytebinder keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def format_date(date) do
    months = ["Jan", "Feb", "Mar", "Apr", "Jun", "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"]
    monthName = Enum.at(months, date.month - 2)
    minute = "#{date.minute}" |> String.pad_leading(2, "0")
    "#{date.day}-#{monthName}-#{date.year} #{date.hour}:#{minute}"
  end
end
