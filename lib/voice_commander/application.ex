defmodule VoiceCommander.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      VoiceCommanderWeb.Telemetry,
      VoiceCommander.Repo,
      {DNSCluster, query: Application.get_env(:voice_commander, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: VoiceCommander.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: VoiceCommander.Finch},
      # Start a worker by calling: VoiceCommander.Worker.start_link(arg)
      # {VoiceCommander.Worker, arg},
      # Start to serve requests, typically the last entry
      VoiceCommanderWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: VoiceCommander.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    VoiceCommanderWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
