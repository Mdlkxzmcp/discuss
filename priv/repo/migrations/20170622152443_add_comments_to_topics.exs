defmodule Discuss.Repo.Migrations.AddCommentsToTopics do
  use Ecto.Migration

  def change do
    create table(:topics_comments) do
      add :content, :string
      add :user_id, references(:accounts_users)
      add :topic_id, references(:topics_topics)


      timestamps()
    end
  end
end
