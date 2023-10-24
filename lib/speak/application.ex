defmodule Speak.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      SpeakWeb.Telemetry,
      # Start the Ecto repository
      Speak.Repo,
      # Start the PubSub system
      {Phoenix.PubSub, name: Speak.PubSub},
      # Start Finch
      {Finch, name: Speak.Finch},
      # Start the Endpoint (http/https)
      SpeakWeb.Endpoint
      # Start a worker by calling: Speak.Worker.start_link(arg)
      # {Speak.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Speak.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    SpeakWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
