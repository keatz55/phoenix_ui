defmodule PhoenixUI.MixProject do
  use Mix.Project

  @version "0.1.0"

  def project do
    [
      app: :phoenix_ui,
      deps: deps(),
      description: description(),
      docs: docs(),
      elixir: "~> 1.12",
      elixirc_options: [warnings_as_errors: true],
      elixirc_paths: elixirc_paths(Mix.env()),
      name: "Phoenix UI",
      package: package(),
      start_permanent: Mix.env() == :prod,
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
      {:ex_doc, "~> 0.24", only: :dev, runtime: false},
      {:jason, "~> 1.2", optional: true},
      {:phoenix_live_view, "~> 0.17.9", optional: true},
      {:phoenix, "~> 1.6", optional: true}
    ]
  end

  defp description do
    """
    The Phoenix UI library you always wanted
    """
  end

  defp docs do
    [
      extras: ["README.md"],
      groups_for_modules: [
        Components: [
          PhoenixUI.Components.Button,
          PhoenixUI.Components.Icon,
          PhoenixUI.Components.Link
        ]
      ],
      main: "PhoenixUI",
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
      maintainers: ["Jace Warren"]
    }
  end
end
