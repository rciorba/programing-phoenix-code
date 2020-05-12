defmodule RumblrWeb.UserController do
  use RumblrWeb, :controller

  alias Rumblr.Accounts
  alias Rumblr.Accounts.User

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.html", users: users)
  end

  def show(conn,  %{"id" => user_id}) do
    user = Accounts.get_user(user_id)
    render(conn, "show.html", user: user)
  end

end
