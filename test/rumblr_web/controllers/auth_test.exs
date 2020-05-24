defmodule RumblrWeb.AuthTest do
  use RumblrWeb.ConnCase, async: true
  alias RumblrWeb.Auth
  alias Rumblr.Accounts.User

  setup %{conn: conn} do
    conn =
      conn
      |> bypass_through(RumblrWeb.Router, :browser)
      |> get("/")

    {:ok, %{conn: conn}}
  end

  test "authenticate_user halts when no current_user exists", %{conn: conn} do
    conn =
      conn
      |> assign(:current_user, nil)
      |> fetch_flash()
      |> Auth.authenticate_user([])

    assert conn.halted
  end

  test "authenticate_user continues when current_user exists", %{conn: conn} do
    conn =
      conn
      |> assign(:current_user, %User{})
      |> fetch_flash()
      |> Auth.authenticate_user([])

    refute conn.halted
  end

  test "login puts the user in the session", %{conn: conn} do
    login_conn =
      conn
      |> Auth.login(%User{id: 123})
      |> send_resp(:ok, "")

    next_conn = get(login_conn, "/")
    assert get_session(next_conn, :user_id) == 123
  end

  test "logout drops the session", %{conn: conn} do
    logout_conn =
      conn
      |> put_session(:user_id, 123)
      |> Auth.logout()
      |> send_resp(:ok, "")

    next_conn = get(logout_conn, "/")
    refute get_session(next_conn, :user_id) == 123
  end

  test "current_user is nil for new session", %{conn: conn} do
    conn = Auth.call(conn, Auth.init([]))
    assert conn.assigns.current_user == nil
  end
end
