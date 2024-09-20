defmodule XQLite.Ecto.MixProject do
  use Mix.Project

  def project do
    [
      app: :xqlite_ecto,
      version: "0.1.0",
      elixir: "~> 1.17",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:xqlite_readers, github: "ruslandoga/xqlite_readers"},
      {:ecto_sql, "~> 3.12"}
    ]
  end
end
