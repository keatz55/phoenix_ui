defmodule PhoenixUI.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      PhoenixUIWeb.Telemetry,
      {DNSCluster, query: Application.get_env(:phoenix_ui, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: PhoenixUI.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: PhoenixUI.Finch},
      # Start a worker by calling: PhoenixUI.Worker.start_link(arg)
      # {PhoenixUI.Worker, arg},
      # Start to serve requests, typically the last entry
      PhoenixUIWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: PhoenixUI.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    PhoenixUIWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
