defmodule RumblrWeb.Auth do
  import Plug.Conn
  import Phoenix.Controller
  alias RumblrWeb.Router.Helpers, as: Routes

  def init(opts), do: opts

  @doc """
  Adds current_user to the connection's assingns.
  Based on get_session
  """
  def call(conn, _opts) do
    user_id = get_session(conn, :user_id)

    cond do
      conn.assigns[:current_user] ->
        conn

      user = user_id && Rumblr.Accounts.get_user(user_id) ->
        assign(conn, :current_user, user)

      true ->
        assign(conn, :current_user, nil)
    end
  end

  def login(conn, user) do
    conn
    |> assign(:current_user, user)
    |> put_session(:user_id, user.id)
    |> configure_session(renew: true)
  end

  def logout(conn) do
    configure_session(conn, drop: true)
    # conn
    # |> assign(:current_user, nil)
    # |> put_session(:user_id, nil)
  end

  def authenticate_user(conn, _opts) do
    if conn.assigns.current_user do
      conn
    else
      conn
      |> put_flash(:error, "You must be logged in!")
      |> redirect(to: Routes.page_path(conn, :index))
      |> halt()
    end
  end
end
