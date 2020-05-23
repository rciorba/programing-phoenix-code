defmodule Rumblr.MultimediaTest do
  use Rumblr.DataCase, async: true

  alias Rumblr.Multimedia

  describe "videos" do
    alias Rumblr.Multimedia.Video

    @valid_attrs %{description: "description", title: "title", url: "http://example.com"}
    @update_attrs %{
      description: "updated description",
      title: "updated title",
      url: "http://example.com/updated"
    }
    @invalid_attrs %{description: nil, title: nil, url: nil}

    test "list_videos/0 returns all videos" do
      user = user_fixture()
      %Video{id: id1} = video_fixture(user, @valid_attrs)
      %Video{id: id2} = video_fixture(user, @valid_attrs)
      # assert Multimedia.list_videos() == [video]
      assert [%Video{id: ^id1}, %Video{id: ^id2}] = Multimedia.list_videos()
    end

    test "get_video!/1 returns the video with given id" do
      user = user_fixture()
      %Video{id: id} = video_fixture(user, @valid_attrs)
      assert %Video{id: ^id} = Multimedia.get_video!(id)
    end

    test "create_video/1 with valid data creates a video" do
      user = user_fixture()
      assert {:ok, %Video{} = video} = Multimedia.create_video(user, @valid_attrs)
      assert video.description == "description"
      assert video.title == "title"
      assert video.url == "http://example.com"
    end

    test "create_video/1 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Multimedia.create_video(user, @invalid_attrs)
    end

    test "update_video/2 with valid data updates the video" do
      user = user_fixture()
      video = video_fixture(user)
      assert {:ok, %Video{} = video} = Multimedia.update_video(video, @update_attrs)
      assert video.description == "updated description"
      assert video.title == "updated title"
      assert video.url == "http://example.com/updated"
    end

    test "update_video/2 with invalid data returns error changeset" do
      user = user_fixture()
      video = video_fixture(user)
      assert {:error, %Ecto.Changeset{}} = Multimedia.update_video(video, @invalid_attrs)
      assert user == Multimedia.get_video!(video.id, preload: [:user]).user

      assert video == Multimedia.get_video!(video.id, preload: [:user])
    end

    test "delete_video/1 deletes the video" do
      user = user_fixture()
      video = video_fixture(user)
      assert {:ok, %Video{}} = Multimedia.delete_video(video)
      assert_raise Ecto.NoResultsError, fn -> Multimedia.get_video!(video.id) end
    end

    test "change_video/1 returns a video changeset" do
      user = user_fixture()
      video = video_fixture(user)
      assert %Ecto.Changeset{} = Multimedia.change_video(video)
    end
  end
end
