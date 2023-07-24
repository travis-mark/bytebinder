defmodule Bytebinder.UserLeague do
  use Ecto.Schema

  schema "user_leagues" do
    belongs_to :user, Bytebinder.User
    belongs_to :league, Bytebinder.League
  end
end
