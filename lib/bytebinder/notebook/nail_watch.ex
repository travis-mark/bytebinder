defmodule Bytebinder.Notebook.NailWatch do
  use Ecto.Schema
  import Ecto.Changeset

  schema "nail_watch" do
    field :date, :date
    field :flag, :string
    field :nails, :integer
    field :skin, :integer
    field :blood, :integer

    timestamps()
  end

  @doc false
  def changeset(nail_watch, attrs) do
    nail_watch
    |> cast(attrs, [:date, :nails, :skin, :blood, :flag])
    |> validate_required([:date, :nails, :skin, :blood, :flag])
  end
end
