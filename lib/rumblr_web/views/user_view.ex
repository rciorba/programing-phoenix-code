defmodule RumblrWeb.UserView do
  use RumblrWeb, :view

  alias Rumblr.Accounts

  def first_name(%Accounts.User{name: name}) do
    name
    |> String.split(" ")
    |> Enum.at(0)
  end

end
