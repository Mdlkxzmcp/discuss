defmodule Discuss.Accounts.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Discuss.Accounts.User

  schema "accounts_users" do
    field :email, :string
    field :username, :string
    field :location, :string
    field :provider, :string
    field :token, :string

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:provider, :email, :username, :location, :token])
    |> validate_required([:provider, :email, :token])
  end

end
