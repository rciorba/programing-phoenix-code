# This fails because it doesn't have the DB setup
defmodule Rumblr.Accounts.AcountsTest do
  use Rumblr.DataCase, async: true

  alias Rumblr.Accounts
  alias Rumblr.Accounts.User

  describe "register_user/1" do
    @valid_attrs %{
      name: "User",
      username: "uname",
      password: "secret"
    }
    @invalid_attrs %{}

    test "with valid data insert user" do
      assert {:ok, %User{id: id} = user} = Accounts.register_user(@valid_attrs)
      assert user.name == "User"
      assert user.username == "uname"
      assert [%User{id: ^id}] = Accounts.list_users()
    end

    test "with invalid data not insert user" do
      assert {:error, _changeset} = Accounts.register_user(@invalid_attrs)
      assert [] = Accounts.list_users()
    end

    test "enforces unique usernames" do
      assert {:ok, %User{id: id}} = Accounts.register_user(@valid_attrs)
      assert {:error, changeset} = Accounts.register_user(@valid_attrs)
      assert %{username: ["has already been taken"]} = errors_on(changeset)
      assert [%User{id: ^id}] = Accounts.list_users()
    end

    test "rejects long usernames" do
      attrs = Map.put(@valid_attrs, :username, String.duplicate("a", 30))
      assert {:error, changeset} = Accounts.register_user(attrs)
      assert %{username: ["should be at most 20 character(s)"]} = errors_on(changeset)
      assert [] = Accounts.list_users()
    end

    test "password should be at least 6 chars long" do
      attrs = Map.put(@valid_attrs, :password, "a")
      assert {:error, changeset} = Accounts.register_user(attrs)
      assert %{password: ["should be at least 6 character(s)"]} = errors_on(changeset)
      assert [] = Accounts.list_users()
    end
  end

  describe "authenticate by username and password" do
    @pass "123456"

    setup do
      {:ok, user: user_fixture(password: @pass)}
    end

    test "returns user with corect password", %{user: user} do
      assert {:ok, auth_user} =
               Accounts.authenticate_by_username_and_password(user.username, @pass)

      assert auth_user.id == user.id
    end
  end

  # test "Account.list_user" do
  #   assert Accounts.list_users() == [
  #     %User{id: "1", name: "Jose Valim", username: "josev"},
  #     %User{id: "2", name: "Bruce Wayne", username: "bruce"},
  #     %User{id: "3", name: "Chris Doe", username: "chris"},
  #   ]
  # end

  # test "Accounts.get_user" do
  #   assert Accounts.get_user("1") == %User{id: "1", name: "Jose Valim", username: "josev"}
  # end

  # test "Accounts.get_user_by" do
  #   assert Accounts.get_user_by(%{username: "bruce"}) == %User{
  #            id: "2",
  #            name: "Bruce Wayne",
  #            username: "bruce"
  #          }
  # end
end
