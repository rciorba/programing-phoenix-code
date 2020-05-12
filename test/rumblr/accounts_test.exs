# This fails because it doesn't have the DB setup
defmodule Rumblr.Accounts.AcountsTest do
  use Rumblr.DataCase, async: true

  alias Rumblr.Accounts
  alias Rumblr.Accounts.User


  # test "Account.list_user" do
  #   assert Accounts.list_users() == [
  #     %User{id: "1", name: "Jose Valim", username: "josev"},
  #     %User{id: "2", name: "Bruce Wayne", username: "bruce"},
  #     %User{id: "3", name: "Chris Doe", username: "chris"},
  #   ]
  # end

  test "Accounts.get_user" do
    assert Accounts.get_user("1") == %User{id: "1", name: "Jose Valim", username: "josev"}
  end

  test "Accounts.get_user_by" do
    assert Accounts.get_user_by(%{username: "bruce"}) == %User{id: "2", name: "Bruce Wayne", username: "bruce"}
  end
end
