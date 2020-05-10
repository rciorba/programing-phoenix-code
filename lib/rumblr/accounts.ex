defmodule Rumblr.Accounts do
  @moduledoc """
  The Acccounts context.
  """

  alias Rumblr.Accounts.User

  def list_users do
    [
      %User{id: "1", name: "Jose Valim", username: "josev"},
      %User{id: "2", name: "Bruce Wayne", username: "bruce"},
      %User{id: "3", name: "Chris Doe", username: "chris"},
    ]
  end

  def get_user(id) do
    # Enum.find(list_users(), fn map -> map.id == id end)
    Enum.find(list_users(), &(&1.id == id))
  end

  def get_user_by(params) do
    Enum.find(
      list_users(),
      fn map->
        Enum.all?(params, fn{key, val} -> Map.get(map, key) == val end)
      end
    )
    # the one above reads better
    # Enum.find(
    #   list_users(),
    #   &(Enum.all?(params, fn{key, val} -> Map.get(&1, key) == val end))
    # )
  end

end
