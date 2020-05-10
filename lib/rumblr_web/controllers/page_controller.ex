defmodule RumblrWeb.PageController do
  use RumblrWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
