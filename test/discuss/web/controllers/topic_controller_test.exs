defmodule Discuss.Web.TopicControllerTest do
  use Discuss.Web.ConnCase

  alias Discuss.Topics

  @create_attrs %{title: "some title"}
  @update_attrs %{title: "some updated title"}
  @invalid_attrs %{title: nil}

  def fixture(:topic) do
    {:ok, topic} = Topics.create_topic(@create_attrs)
    topic
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, topic_path(conn, :index)
    assert html_response(conn, 200) =~ "Topics"
  end

  test "renders form for new topics", %{conn: conn} do
    conn = get conn, topic_path(conn, :new)
    assert html_response(conn, 200) =~ "New Topic"
  end

  test "creates topic and redirects to show when data is valid", %{conn: conn} do
    conn = post conn, topic_path(conn, :create), topic: @create_attrs

    assert %{id: id} = redirected_params(conn)
    assert redirected_to(conn) == topic_path(conn, :show, id)

    conn = get conn, topic_path(conn, :show, id)
    assert html_response(conn, 200) =~ "Topic"
  end

  test "does not create topic and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, topic_path(conn, :create), topic: @invalid_attrs
    assert html_response(conn, 200) =~ "New Topic"
  end

  test "renders form for editing chosen topic", %{conn: conn} do
    topic = fixture(:topic)
    conn = get conn, topic_path(conn, :edit, topic)
    assert html_response(conn, 200) =~ "Edit Topic"
  end

  test "updates chosen topic and redirects when data is valid", %{conn: conn} do
    topic = fixture(:topic)
    conn = put conn, topic_path(conn, :update, topic), topic: @update_attrs
    assert redirected_to(conn) == topic_path(conn, :show, topic)

    conn = get conn, topic_path(conn, :show, topic)
    assert html_response(conn, 200) =~ "some updated title"
  end

  test "does not update chosen topic and renders errors when data is invalid", %{conn: conn} do
    topic = fixture(:topic)
    conn = put conn, topic_path(conn, :update, topic), topic: @invalid_attrs
    assert html_response(conn, 200) =~ "Edit Topic"
  end

  test "deletes chosen topic", %{conn: conn} do
    topic = fixture(:topic)
    conn = delete conn, topic_path(conn, :delete, topic)
    assert redirected_to(conn) == topic_path(conn, :index)
    assert_error_sent 404, fn ->
      get conn, topic_path(conn, :show, topic)
    end
  end
end
