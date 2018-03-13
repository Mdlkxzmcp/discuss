defmodule Discuss.Web.CommentsChannel do
  use Discuss.Web, :channel
  alias Discuss.Topics

  def join("comments:" <> topic_id, _params, socket) do
    topic =
      topic_id
      |> String.to_integer()
      |> Topics.get_topic_with_comments()

    {:ok, %{comments: topic.comments}, assign(socket, :topic, topic)}
  end

  def handle_in(_name, %{"content" => content}, socket) do
    topic = socket.assigns.topic
    user_id = socket.assigns[:user_id]

    case Topics.create_comment(topic, user_id, %{content: content}) do
      {:ok, comment} ->
        broadcast!(socket, "comments:#{socket.assigns.topic.id}:new", %{comment: comment})
        {:reply, :ok, socket}

      {:error, reason} ->
        {:reply, {:error, %{errors: reason}}, socket}
    end
  end
end
