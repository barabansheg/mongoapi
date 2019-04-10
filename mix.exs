defmodule MongoApi.MixProject do
  use Mix.Project

  def project do
    [
      app: :mongoapi,
      version: "0.1.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {MongoApi, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:mongodb, "== 0.4.6"},
      {:poolboy, ">= 0.0.0"},
    ]
  end
end
