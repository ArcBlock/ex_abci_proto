defmodule ExAbciProto.MixProject do
  use Mix.Project
  @version File.cwd!() |> Path.join("version") |> File.read!() |> String.trim()
  @elixir_version File.cwd!() |> Path.join(".elixir_version") |> File.read!() |> String.trim()

  def project do
    [
      app: :ex_abci_proto,
      version: @version,
      elixir: @elixir_version,
      description: description(),
      package: package(),
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      # Docs
      name: "ExAbciProto",
      source_url: "https://github.com/arcblock/ex_abci_proto",
      homepage_url: "https://github.com/arcblock/ex_abci_proto",
      docs: [
        main: "ExAbciProto",
        extras: ["README.md"]
      ]
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
      {:google_protos, "~> 0.1"},
      {:grpc, "~> 0.3"},
      {:protobuf, github: "tony612/protobuf-elixir", branch: "decode-performance", override: true},

      # dev and test
      {:ex_doc, "~> 0.19.0", only: [:dev, :test], runtime: false}
    ]
  end

  defp description do
    """
    [Tendermint ABCI protos](https://github.com/tendermint/tendermint/wiki/Application-Developers). Extracted from [ex_abci](https://github.com/arcblock/ex_abci).
    """
  end

  defp package do
    [
      files: [
        "config",
        "lib",
        "mix.exs",
        "README*",
        "version",
        ".elixir_version"
      ],
      licenses: ["Apache 2.0"],
      maintainers: ["tyr.chen@gmail.com"],
      links: %{
        "GitHub" => "https://github.com/arcblock/ex_abci_proto",
        "Docs" => "https://hexdocs.pm/ex_abci_proto"
      }
    ]
  end
end
