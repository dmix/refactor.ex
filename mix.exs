defmodule Refactor.Mixfile do
  use Mix.Project

  def project do
    [
      app: :refactor,
      version: "0.1.0",
      elixir: "~> 1.5",
      escript: [main_module: Refactor],
      start_permanent: Mix.env == :prod,
      deps: deps(),
      aliases: aliases(),
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:mix_test_watch, "~> 0.3", only: [:dev, :test], runtime: false},
      {:inflex, "~> 1.8.0"},
      {:credo, "~> 0.8", only: [:dev, :test], runtime: false},
    ]
  end

  defp aliases do
    [
      "dev": [
        "test.watch"
      ]
    ]
  end
end
