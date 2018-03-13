defmodule Discuss.Topics do
  @moduledoc """
  The boundary for the Topics system.
  """

  import Ecto.Query, warn: false
  alias Discuss.Repo

  alias Discuss.Topics.Topic

  @doc """
  Returns the list of topics.

  ## Examples

      iex> list_topics()
      [%Topic{}, ...]

  """
  def list_topics do
    Repo.all(Topic)
  end

  @doc """
  Gets a singe topic.

  ## Examples

      iex> get_topic(123)
      %Topic{}

      iex> get_topic(456)
      nil

  """
  def get_topic(id) do
    Repo.get(Topic, id)
  end

  @doc """
  Gets a single topic.

  Raises `Ecto.NoResultsError` if the Topic does not exist.

  ## Examples

      iex> get_topic!(123)
      %Topic{}

      iex> get_topic!(456)
      ** (Ecto.NoResultsError)

  """
  def get_topic!(id) do
    Repo.get!(Topic, id)
  end

  @doc """
  Creates a topic.

  ## Examples

      iex> create_topic(%{field: value})
      {:ok, %Topic{}}

      iex> create_topic(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_topic(attrs \\ %{}) do
    %Topic{}
    |> Topic.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Creates a topic.

  ## Examples

      iex> create_topic(topic, %{field: value})
      {:ok, %Topic{}}

      iex> create_topic(topic, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_topic(%Topic{} = topic, attrs) do
    topic
    |> Topic.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a topic.

  ## Examples

      iex> update_topic(topic, %{field: new_value})
      {:ok, %Topic{}}

      iex> update_topic(topic, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_topic(%Topic{} = topic, attrs) do
    topic
    |> Topic.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Topic.

  Raises `Ecto.NoResultsError` if the Topic does not exist.

  ## Examples

      iex> delete_topic!(topic)
      {:ok, %Topic{}}

      iex> delete_topic!(topic)
      ** (Ecto.NoResultsError)

  """
  def delete_topic!(%Topic{} = topic) do
    Repo.delete!(topic)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking topic changes.

  ## Examples

      iex> change_topic(topic)
      %Ecto.Changeset{source: %Topic{}}

  """
  def change_topic(%Topic{} = topic) do
    Topic.changeset(topic, %{})
  end

  alias Discuss.Topics.Comment

  @doc """
  Creates a comment by a user under a topic.

  ## Examples

      iex> create_comment(topic, %{field: value})
      {:ok, %Comment{}}

      iex> create_comment(topic, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_comment(%Topic{} = topic, user_id, attrs \\ %{}) do
    Ecto.build_assoc(topic, :comments, user_id: user_id)
    |> Comment.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Gets a single topic with all the associated comments.
  For each comment the user is also returned.

  ### Examples

      iex> get_topic_with_comments(123)
      %Topic{comments: [%Comment{}, %Comment{}]}

      iex> get_topic_with_comments(456)
      nil

  """
  def get_topic_with_comments(id) do
    get_topic(id)
    |> Repo.preload(comments: [:user])
  end
end
