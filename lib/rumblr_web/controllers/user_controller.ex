defmodule RumblrWeb.UserController do
  use RumblrWeb, :controller

  alias Rumblr.Accounts
  alias Rumblr.Accounts.User
  plug :authenticate_user when action in [:index, :show]

  def new(conn, _params) do
    changeset = Accounts.change_registration(%User{})
    IO.inspect(changeset)
    render(conn, "new.html", changeset: changeset)
  end

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.html", users: users)
  end

  def show(conn, %{"id" => user_id}) do
    user = Accounts.get_user(user_id)
    render(conn, "show.html", user: user)
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.register_user(user_params) do
      {:ok, user} ->
        conn
        |> RumblrWeb.Auth.login(user)
        |> put_flash(:info, "#{user.username} created!")
        |> redirect(to: Routes.user_path(conn, :index))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

end
