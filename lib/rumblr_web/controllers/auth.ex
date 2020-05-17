defmodule RumblrWeb.Auth do

  import Plug.Conn

  def init(opts), do: opts

  @doc """
  Adds current_user to the connection's assingns.
  Based on get_session
  """
  def call(conn, _opts) do
    user_id = get_session(conn, :user_id)
    user = user_id && Rumblr.Accounts.get_user(user_id)
    # assign comes from Plug.Conn and adds current_user=user to the conn's assigns
    assign(conn, :current_user, user)
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

end
