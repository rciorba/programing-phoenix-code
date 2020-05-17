defmodule RumblrWeb.Noop do
  def init(opts) do
    IO.puts("init: ")
    IO.inspect(opts)
  end

  def call(conn, opts) do
    IO.puts("call ")
    IO.inspect(conn, opts)
    conn
  end
end
