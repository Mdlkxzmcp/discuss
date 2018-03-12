defmodule Discuss.Web.TopicController do
  use Discuss.Web, :controller

  alias Discuss.Topics

  plug(Discuss.Web.Plugs.RequireAuth when action in [:new, :create, :edit, :update, :delete])
  plug(:check_topic_owner when action in [:update, :edit, :delete])

  def index(conn, _params) do
    topics = Topics.list_topics()
    render(conn, "index.html", topics: topics)
  end

  def new(conn, _params) do
    changeset = Topics.change_topic(%Topics.Topic{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"topic" => topic_params}) do
    case create_with_association(conn, topic_params) do
      {:ok, topic} ->
        conn
        |> put_flash(:info, "Topic Created")
        |> redirect(to: topic_path(conn, :show, topic))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    topic = Topics.get_topic!(id)
    render(conn, "show.html", topic: topic)
  end

  def edit(conn, %{"id" => id}) do
    topic = Topics.get_topic!(id)
    changeset = Topics.change_topic(topic)
    render(conn, "edit.html", topic: topic, changeset: changeset)
  end

  def update(conn, %{"id" => id, "topic" => topic_params}) do
    topic = Topics.get_topic!(id)

    case Topics.update_topic(topic, topic_params) do
      {:ok, topic} ->
        conn
        |> put_flash(:info, "Topic Updated")
        |> redirect(to: topic_path(conn, :show, topic))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", topic: topic, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    Topics.get_topic!(id) |> Topics.delete_topic!()

    conn
    |> put_flash(:info, "Topic Deleted")
    |> redirect(to: topic_path(conn, :index))
  end

  defp check_topic_owner(%{params: %{"id" => topic_id}} = conn, _params) do
    if Topics.get_topic(topic_id).user_id == conn.assigns.user.id do
      conn
    else
      conn
      |> put_flash(:error, "You cannot do that you silly goose!")
      |> redirect(to: topic_path(conn, :index))
      |> halt()
    end
  end

  defp create_with_association(conn, topic_params) do
    conn.assigns.user
    |> Ecto.build_assoc(:topics)
    |> Topics.create_topic(topic_params)
  end
end
