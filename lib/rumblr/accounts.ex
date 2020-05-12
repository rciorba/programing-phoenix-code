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

end
