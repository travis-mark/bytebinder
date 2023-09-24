defmodule Bytebinder.NotebookFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Bytebinder.Notebook` context.
  """

  @doc """
  Generate a nail_watch.
  """
  def nail_watch_fixture(attrs \\ %{}) do
    {:ok, nail_watch} =
      attrs
      |> Enum.into(%{
        date: ~D[2023-09-23],
        flag: "some flag",
        nails: 42,
        skin: 42,
        blood: 42
      })
      |> Bytebinder.Notebook.create_nail_watch()

    nail_watch
  end
end
