defmodule Phoenix.UI.MixProject do
  use Mix.Project

  @version "0.1.8"

  def project do
    [
      app: :phoenix_ui,
      deps: deps(),
      description: description(),
      dialyzer: [
        plt_add_apps: [:mix, :phoenix_html, :phoenix_live_view, :phoenix, :plug],
        plt_file: {:no_warn, "priv/plts/dialyzer.plt"}
      ],
      docs: docs(),
      elixir: "~> 1.12",
      elixirc_options: [warnings_as_errors: true],
      elixirc_paths: elixirc_paths(Mix.env()),
      homepage_url: "https://phoenix-ui.fly.dev",
      name: "Phoenix UI",
      package: package(),
      preferred_cli_env: [
        coveralls: :test,
        "coveralls.detail": :test,
        "coveralls.post": :test,
        "coveralls.html": :test
      ],
      source_url: "https://github.com/keatz55/phoenix_ui",
      start_permanent: Mix.env() == :prod,
      test_coverage: [tool: ExCoveralls],
      version: @version
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},
      {:doctor, "~> 0.18.0", only: :dev},
      {:ex_doc, "~> 0.27", only: :dev, runtime: false},
      {:excoveralls, "~> 0.14", only: :test, runtime: false},
      {:jason, "~> 1.2", optional: true},
      {:phoenix_live_view, "~> 0.20.1", optional: true},
      {:phoenix, "~> 1.7", optional: true}
    ]
  end

  defp description do
    """
    A complimentary UI library for the Phoenix Framework and Phoenix LiveView.
    """
  end

  defp docs do
    [
      extras: ["README.md"],
      main: "Phoenix.UI",
      source_ref: "v#{@version}",
      source_url: "https://github.com/keatz55/phoenix_ui"
    ]
  end

  defp elixirc_paths(:test), do: ["lib", "test/support"]
  defp elixirc_paths(_), do: ["lib"]

  defp package do
    %{
      files: ~w(lib LICENSE.md mix.exs README.md),
      licenses: ["MIT"],
      links: %{github: "https://github.com/keatz55/phoenix_ui"},
      maintainers: ["Jace Warren"],
      name: "phoenix_ui"
    }
  end
end
