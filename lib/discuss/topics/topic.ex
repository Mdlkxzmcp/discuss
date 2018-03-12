defmodule Discuss.Topics.Topic do
  use Ecto.Schema
  import Ecto.Changeset
  alias Discuss.Topics.Topic
  alias Discuss.{Accounts, Topics}

  schema "topics_topics" do
    field(:title, :string)
    belongs_to(:user, Accounts.User)
    has_many(:comments, Topics.Comment)

    timestamps()
  end

  @doc false
  def changeset(%Topic{} = topic, attrs) do
    topic
    |> cast(attrs, [:title])
    |> validate_required([:title])
  end
end
