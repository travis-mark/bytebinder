defmodule Bytebinder.Repo do
  use Ecto.Repo,
    otp_app: :bytebinder,
    adapter: Ecto.Adapters.Postgres
end
