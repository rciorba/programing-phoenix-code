defmodule RumblrWeb.VideoControllerTest do
  alias Rumblr.Multimedia
  use RumblrWeb.ConnCase, async: true

  test "requires user auth on all actions", %{conn: conn} do
    Enum.each(
      [
        get(conn, Routes.video_path(conn, :new)),
        get(conn, Routes.video_path(conn, :index)),
        get(conn, Routes.video_path(conn, :show, "123")),
        get(conn, Routes.video_path(conn, :edit, "123")),
        put(conn, Routes.video_path(conn, :update, "123", %{}))
      ],
      fn conn ->
        assert html_response(conn, 302)
        assert conn.halted
      end
    )
  end

  test "non owner can't access videos", %{conn: conn} do
    owner = user_fixture(username: "owner")
    video = video_fixture(owner)
    non_owner = user_fixture(username: "non_owner")
    conn = assign(conn, :current_user, non_owner)

    Enum.each(
      [
        fn -> get(conn, Routes.video_path(conn, :show, video.id)) end,
        fn -> get(conn, Routes.video_path(conn, :edit, video.id)) end,
        fn -> get(conn, Routes.video_path(conn, :update, video.id, %{})) end,
        fn -> get(conn, Routes.video_path(conn, :delete, video.id, %{})) end
      ],
      fn action ->
        assert_error_sent :not_found, action
      end
    )
  end

  describe "logged in tests" do
    setup %{conn: conn, login_as: username} do
      user = user_fixture(username: username)
      conn = assign(conn, :current_user, user)
      {:ok, conn: conn, user: user}
    end

    @tag login_as: "max"
    test "list videos for user", %{conn: conn, user: user} do
      user_video = video_fixture(user, title: "catz")
      other_video = video_fixture(user_fixture(), title: "dogz")

      conn = get(conn, Routes.video_path(conn, :index))
      response = html_response(conn, 200)
      assert response =~ user_video.title
      refute response =~ other_video.title
    end

    @create_attrs %{
      url: "http://example.com",
      title: "title",
      description: "a description"
    }

    @tag login_as: "max"
    test "creates video and redirects", %{conn: conn, user: user} do
      create_conn = post conn, Routes.video_path(conn, :create), video: @create_attrs
      assert %{id: id} = redirected_params(create_conn)
      assert redirected_to(create_conn) == Routes.video_path(create_conn, :show, id)
      video = Multimedia.get_video!(id)
      assert video.user_id == user.id
      assert @create_attrs = video
    end
  end
end
