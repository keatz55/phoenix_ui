defmodule PhoenixUI.MixProject do
  use Mix.Project

  def project do
    [
      app: :phoenix_ui,
      version: "0.1.0",
      elixir: "~> 1.14",
      elixirc_paths: elixirc_paths(Mix.env()),
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Configuration for the OTP application.
  #
  # Type `mix help compile.app` for more information.
  def application do
    [
      mod: {PhoenixUI.Application, []},
      extra_applications: [:logger, :runtime_tools]
    ]
  end

  # Specifies which paths to compile per environment.
  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  # Specifies your project dependencies.
  #
  # Type `mix help deps` for examples and options.
  defp deps do
    [
      {:bandit, "~> 1.5"},
      {:dns_cluster, "~> 0.1.1"},
      {:esbuild, "~> 0.8", runtime: Mix.env() == :dev},
      {:finch, "~> 0.13"},
      {:floki, ">= 0.30.0", only: :test},
      {:gettext, "~> 0.20"},
      {:heroicons,
       app: false,
       compile: false,
       depth: 1,
       github: "tailwindlabs/heroicons",
       override: true,
       sparse: "optimized",
       tag: "v2.1.1"},
      {:jason, "~> 1.2"},
      {:phoenix_html, "~> 4.1"},
      {:phoenix_live_dashboard, "~> 0.8.3"},
      {:phoenix_live_reload, "~> 1.2", only: :dev},
      {:phoenix_live_view, "~> 1.0.0-rc.1", override: true},
      {:phoenix_storybook,
       git: "https://github.com/keatz55/phoenix_storybook", branch: "jw/increase-icon-flexibility"},
      {:phoenix, "~> 1.7.14"},
      {:swoosh, "~> 1.5"},
      {:tailwind, "~> 0.2", runtime: Mix.env() == :dev},
      {:telemetry_metrics, "~> 1.0"},
      {:telemetry_poller, "~> 1.0"}
    ]
  end

  # Aliases are shortcuts or tasks specific to the current project.
  # For example, to install project dependencies and perform other setup tasks, run:
  #
  #     $ mix setup
  #
  # See the documentation for `Mix` for more info on aliases.
  defp aliases do
    [
      setup: ["deps.get", "assets.setup", "assets.build"],
      "assets.setup": ["tailwind.install --if-missing", "esbuild.install --if-missing"],
      "assets.build": ["tailwind phoenix_ui", "esbuild phoenix_ui"],
      "assets.deploy": [
        "tailwind phoenix_ui --minify",
        "tailwind storybook --minify",
        "esbuild phoenix_ui --minify",
        "phx.digest"
      ]
    ]
  end
end
