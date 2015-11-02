defmodule Drawille.Mixfile do
  use Mix.Project

  def project do
    [app: :drawille,
     version: "0.0.1",
     elixir: "~> 1.1",
     description: "Drawings using terminal braille characters.",
     package: [
       maintainers: ["Massn"],
       licenses: ["MIT"],
       links: %{"GitHub" => "https://github.com/massn/elixir-drawille"}],
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.10.0"},
      {:earmark, "~> 0.1.19"}
    ]
  end
end
