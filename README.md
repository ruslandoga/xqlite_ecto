Separate namespace for https://github.com/elixir-sqlite/ecto_sqlite3 experiments.

```elixir
defmodule MyApp.Repo do
  use Ecto.Repo, adapter: XQLite.Ecto, otp_app: :my_app
end
```
