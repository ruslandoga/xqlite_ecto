defmodule XQLite.Ecto do
  @moduledoc "SQLite for Ecto"
  @behaviour Ecto.Adapter
  @behaviour Ecto.Adapter.Migration
  @behaviour Ecto.Adapter.Queryable
  @behaviour Ecto.Adapter.Schema
  @behaviour Ecto.Adapter.Transaction
  @behaviour Ecto.Adapter.Storage
  @behaviour Ecto.Adapter.Structure

  @conn XQLite.Ecto.Connection

  @impl Ecto.Adapter
  defmacro __before_compile__(_env) do
    quote do
      @doc """
      A convenience function for SQL-based repositories that executes the given query.

      See `Ecto.Adapters.SQL.query/4` for more information.
      """
      def query(sql, params \\ [], opts \\ []) do
        Ecto.Adapters.SQL.query(get_dynamic_repo(), sql, params, opts)
      end

      @doc """
      A convenience function for SQL-based repositories that executes the given query.

      See `Ecto.Adapters.SQL.query!/4` for more information.
      """
      def query!(sql, params \\ [], opts \\ []) do
        Ecto.Adapters.SQL.query!(get_dynamic_repo(), sql, params, opts)
      end

      @doc """
      A convenience function for SQL-based repositories that translates the given query to SQL.

      See `Ecto.Adapters.SQL.to_sql/3` for more information.
      """
      def to_sql(operation, queryable) do
        XQLite.Ecto.to_sql(operation, queryable)
      end
    end
  end

  @impl Ecto.Adapter
  def ensure_all_started(config, type) do
    Ecto.Adapters.SQL.ensure_all_started(@driver, config, type)
  end

  @impl Ecto.Adapter
  def init(config) do
    Ecto.Adapters.SQL.init(@conn, @driver, config)
  end
end
