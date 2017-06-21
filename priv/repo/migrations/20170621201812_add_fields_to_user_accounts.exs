defmodule Discuss.Repo.Migrations.AddFieldsToUserAccounts do
  use Ecto.Migration

  def change do
    alter table(:accounts_users) do
      add :username, :string
    end

    create unique_index(:accounts_users, [:email, :username])
  end
end
