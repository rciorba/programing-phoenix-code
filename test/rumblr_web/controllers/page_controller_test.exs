defmodule RumblrWeb.PageControllerTest do
  use RumblrWeb.ConnCase, async: true

  test "GET /", %{conn: conn} do
    conn = get(conn, "/")
    assert html_response(conn, 200) =~ "Welcome to Rumblr.io!"
  end
end
