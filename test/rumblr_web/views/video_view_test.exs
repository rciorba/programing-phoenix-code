defmodule RumblrWeb.VideoViewTest do
  alias Rumblr.Multimedia
  alias Rumblr.Multimedia.Video
  alias Rumblr.Accounts.User

  use RumblrWeb.ConnCase, async: true
  import Phoenix.View

  test "renders index.html", %{conn: conn} do
    videos = [
      %Video{id: 1, title: "dogz"},
      %Video{id: 2, title: "catz"}
    ]

    content =
      render_to_string(
        RumblrWeb.VideoView,
        "index.html",
        conn: conn,
        videos: videos
      )

    assert String.contains?(content, "Listing Videos")
  end

  test "renders new.html", %{conn: conn} do
    owner = %User{}
    changeset = Multimedia.change_video(%Video{})

    categories = [
      %Multimedia.Category{id: 123, name: "catz"}
    ]

    content =
      render_to_string(
        RumblrWeb.VideoView,
        "new.html",
        conn: conn,
        changeset: changeset,
        categories: categories
      )

    assert String.contains?(content, "New Video")
  end
end
