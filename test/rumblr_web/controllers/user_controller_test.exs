defmodule RumblrWeb.UserControllerTest do
  use RumblrWeb.ConnCase

  test "GET /users", %{conn: conn} do
    conn = get(conn, "/users")
    assert html_response(conn, 200) =~ "Users:"
  end
end
