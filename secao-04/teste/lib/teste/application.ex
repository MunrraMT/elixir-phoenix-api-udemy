defmodule Teste.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      TesteWeb.Telemetry,
      Teste.Repo,
      {DNSCluster, query: Application.get_env(:teste, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: Teste.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: Teste.Finch},
      # Start a worker by calling: Teste.Worker.start_link(arg)
      # {Teste.Worker, arg},
      # Start to serve requests, typically the last entry
      TesteWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Teste.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    TesteWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
