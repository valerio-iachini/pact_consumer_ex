defmodule PactElixir.MixProject do
  use Mix.Project

  def project do
    [
      app: :pact_consumer_ex,
      version: "0.2.0",
      elixir: "~> 1.16",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: "Elixir NIF bindings for the pact_consumer Rust library.",
      package: package()
    ]
  end

  defp package do
    [
      name: "pact_consumer_ex",
      licenses: ["MIT"],
      links: %{"GitHub" => "https://github.com/valerio-iachini/pact_consumer_ex"},
      maintainers: ["Valerio Iachini"],
      files: [
        "lib",
        "native",
        "Cargo.toml",
        "Cargo.lock",
        "mix.exs",
        "README.md",
        "LICENSE"
      ]
    ]
  end

  defp deps do
    [
      {:rustler, "~> 0.36.1"},
      {:jason, "~> 1.4.4"},
      {:httpoison, "~> 2.2.2", only: [:test]},
      {:credo, "~> 1.7", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.4", only: [:dev], runtime: false},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end
end
