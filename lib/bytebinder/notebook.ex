defmodule Bytebinder.Notebook do
  @moduledoc """
  The Notebook context.
  """

  import Ecto.Query, warn: false
  alias Bytebinder.Repo

  alias Bytebinder.Notebook.NailWatch

  @doc """
  Returns the list of nail_watch.

  ## Examples

      iex> list_nail_watch()
      [%NailWatch{}, ...]

  """
  def list_nail_watch do
    Repo.all(NailWatch)
  end

  @doc """
  Gets a single nail_watch.

  Raises `Ecto.NoResultsError` if the Nail watch does not exist.

  ## Examples

      iex> get_nail_watch!(123)
      %NailWatch{}

      iex> get_nail_watch!(456)
      ** (Ecto.NoResultsError)

  """
  def get_nail_watch!(id), do: Repo.get!(NailWatch, id)

  @doc """
  Creates a nail_watch.

  ## Examples

      iex> create_nail_watch(%{field: value})
      {:ok, %NailWatch{}}

      iex> create_nail_watch(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_nail_watch(attrs \\ %{}) do
    %NailWatch{}
    |> NailWatch.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a nail_watch.

  ## Examples

      iex> update_nail_watch(nail_watch, %{field: new_value})
      {:ok, %NailWatch{}}

      iex> update_nail_watch(nail_watch, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_nail_watch(%NailWatch{} = nail_watch, attrs) do
    nail_watch
    |> NailWatch.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a nail_watch.

  ## Examples

      iex> delete_nail_watch(nail_watch)
      {:ok, %NailWatch{}}

      iex> delete_nail_watch(nail_watch)
      {:error, %Ecto.Changeset{}}

  """
  def delete_nail_watch(%NailWatch{} = nail_watch) do
    Repo.delete(nail_watch)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking nail_watch changes.

  ## Examples

      iex> change_nail_watch(nail_watch)
      %Ecto.Changeset{data: %NailWatch{}}

  """
  def change_nail_watch(%NailWatch{} = nail_watch, attrs \\ %{}) do
    NailWatch.changeset(nail_watch, attrs)
  end
end
