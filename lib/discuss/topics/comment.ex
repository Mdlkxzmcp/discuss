defmodule Discuss.Topics.Comment do
  use Ecto.Schema
  import Ecto.Changeset
  alias Discuss.Topics.Comment
  alias Discuss.{Accounts, Topics}

  schema "topics_comments" do
    field(:content, :string)
    belongs_to(:user, Accounts.User)
    belongs_to(:topic, Topics.Topic)

    timestamps()
  end

  @doc false
  def changeset(%Comment{} = comment, attrs) do
    comment
    |> cast(attrs, [:content])
    |> validate_required([:content])
  end
end
