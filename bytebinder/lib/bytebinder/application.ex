defmodule Bytebinder.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      BytebinderWeb.Telemetry,
      # Start the Ecto repository
      Bytebinder.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Bytebinder.PubSub},
      # Start Finch
      {Finch, name: Bytebinder.Finch},
      # Start the Endpoint (http/https)
      BytebinderWeb.Endpoint
      # Start a worker by calling: Bytebinder.Worker.start_link(arg)
      # {Bytebinder.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Bytebinder.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    BytebinderWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
