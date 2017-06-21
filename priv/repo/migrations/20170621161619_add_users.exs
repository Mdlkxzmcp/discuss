defmodule Discuss.Repo.Migrations.Accounts.User do
  use Ecto.Migration

  def change do
    create table(:accounts_users) do
      add :email, :string
      add :location, :string
      add :provider, :string
      add :token, :string

      timestamps()
    end
  end
end
