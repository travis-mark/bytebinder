defmodule Bytebinder.AdminFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Bytebinder.Admin` context.
  """

  @doc """
  Generate a game.
  """
  def game_fixture(attrs \\ %{}) do
    {:ok, game} =
      attrs
      |> Enum.into(%{
        game: "some game",
        game_no: "some game_no",
        solution: "some solution",
        release_date: ~D[2023-08-25]
      })
      |> Bytebinder.Admin.create_game()

    game
  end
end
