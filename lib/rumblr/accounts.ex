defmodule Rumblr.Accounts do
  @moduledoc """
  The Acccounts context.
  """

  alias Rumblr.Repo
  alias Rumblr.Accounts.User

  def list_users do
    Repo.all(User)
  end

  def get_user(id) do
    Repo.get(User, id)
  end

  def get_user!(id) do
    Repo.get!(User, id)
  end

  def get_user_by(params) do
    Repo.get_by(User, params)
    # the one above reads better
    # Enum.find(
    #   list_users(),
    #   &(Enum.all?(params, fn{key, val} -> Map.get(&1, key) == val end))
    # )
  end

  def change_user(%User{} = user) do
    User.changeset(user, %{})
  end

  def change_registration(%User{} = user) do
    User.registration_changeset(user, %{})
  end

  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> IO.inspect()
    |> Repo.insert()
    |> IO.inspect()
  end

  def register_user(attrs) do
    %User{}
    |> User.registration_changeset(attrs)
    |> Repo.insert()
  end

  def authenticate_by_username_and_password(username, password) do
    user = get_user_by(username: username)
    cond do
      user && Pbkdf2.verify_pass(password, user.password_hash) ->
        {:ok, user}
      user ->
        {:error, :unauthorized}
      true ->
        Pbkdf2.no_user_verify()
        {:error, :not_found}
    end
  end
end
