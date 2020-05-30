defmodule RumblrWeb.WatchController do
  use RumblrWeb, :controller

  alias Rumblr.Multimedia
  # alias Rumblr.Multimedia.Video

  def show(conn, %{"id" => id}) do
    video = Multimedia.get_video!(id)
    render(conn, "show.html", video: video)
  end
end
