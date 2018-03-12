defmodule Discuss.Repo.Migrations.AddUserIdFieldToTopics do
  use Ecto.Migration

  def change do
    alter table(:topics_topics) do
      add :user_id, references(:accounts_users)
    end
  end

end
