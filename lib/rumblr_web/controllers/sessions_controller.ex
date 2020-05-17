defmodule RumblrWeb.SessionController do
  use RumblrWeb, :controller

  alias Rumblr.Accounts

  def new(conn, _) do
    render(conn, "new.html")
  end

  def create(conn,
    %{"session" => %{
        "username" => username,
        "password" => password,
    }
    }) do
    # session = %{
    #   "username": username,
    #   "password": password,
    # }
    # IO.inspect(session)
    # username = session["username"]
    # password = session["password"]
    case Accounts.authenticate_by_username_and_password(username, password) do
      {:ok, user} ->
        conn
        |> RumblrWeb.Auth.login(user)
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Invalid username/password combination")
        |> render("new.html")
    end
  end

  def delete(conn, _) do
    conn
    |> RumblrWeb.Auth.logout()
    |> redirect(to: Routes.page_path(conn, :index))
  end

end
