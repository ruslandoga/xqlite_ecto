defmodule XQLite.Ecto.Connection do
  @moduledoc false
  @behaviour Ecto.Adapters.SQL.Connection

  alias Ecto.SubQuery
  alias Ecto.Query.{QueryExpr, ByExpr, JoinExpr, BooleanExpr, WithExpr, Tagged}

  @impl true
  def prepare_execute(conn, _name, statement, params, opts) do
    query = Ch.Query.build(statement, opts[:command])
    DBConnection.prepare_execute(conn, query, params, opts)
  end

  @impl true
  def execute(conn, query, params, opts) do
    DBConnection.execute(conn, query, params, opts)
  end

  @impl true
  def query(conn, statement, params, opts) do
    Ch.query(conn, statement, params, opts)
  end

  @impl true
  def query_many(_conn, _statement, _params, _opts) do
    raise "not implemented"
  end

  @impl true
  def stream(_conn, _statement, _params, _opts) do
    raise "not implemented"
  end

  @impl true
  def to_constraints(_exception, _opts) do
    raise "not implemented"
  end

  @impl true
  def all(query, as_prefix \\ []) do
    sources = create_names(query, as_prefix)

    cte = cte(query, sources)
    from = from(query, sources)
    select = select(query, sources)
    join = join(query, sources)
    where = where(query, sources)
    group_by = group_by(query, sources)
    having = having(query, sources)
    window = window(query, sources)
    order_by = order_by(query, sources)
    limit = limit(query, sources)
    offset = offset(query, sources)
    combinations = combinations(query)

    [
      cte,
      select,
      from,
      join,
      where,
      group_by,
      having,
      window,
      order_by,
      limit,
      offset,
      combinations
    ]
  end

  @impl true
  def update_all(query, _prefix \\ nil) do
    raise "todo"
  end
end
