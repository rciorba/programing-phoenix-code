defmodule RumblrWeb.PageControllerTest do
  use RumblrWeb.ConnCase

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to Rumblr.io!"
  end
end
