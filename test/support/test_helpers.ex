defmodule Rumblr.TestHelpers do
  alias Rumblr.{Accounts, Multimedia}

  def user_fixture(attrs \\ %{}) do
    {:ok, user} =
      attrs
      |> Enum.into(%{
        name: "Some Name",
        username: "user_#{System.unique_integer([:positive])}",
        password: attrs[:password] || "supersecret"
      })
      |> Accounts.register_user()

    %Accounts.User{user | password: nil}
  end

  def video_fixture(%Accounts.User{} = user, attrs \\ %{}) do
    attrs =
      Enum.into(
        attrs,
        %{
          title: "A Title",
          url: "http://example.com",
          description: "a description"
        }
      )

    {:ok, video} = Multimedia.create_video(user, attrs)
    video
  end
end
