defmodule Discuss.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Discuss.Accounts.User
  alias Discuss.Topics

  schema "accounts_users" do
    field(:email, :string)
    field(:username, :string)
    field(:location, :string)
    field(:provider, :string)
    field(:token, :string)
    has_many(:topics, Topics.Topic)
    has_many(:comments, Topics.Comment)

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:provider, :email, :username, :location, :token])
    |> validate_required([:provider, :email, :token])
    |> validate_format(:email, ~r/@/)
    |> unique_constraint([:email, :username])
  end
end
