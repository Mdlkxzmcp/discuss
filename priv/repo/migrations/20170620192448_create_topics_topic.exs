defmodule Discuss.Repo.Migrations.CreateDiscuss.Topics.Topic do
  use Ecto.Migration

  def change do
    create table(:topics_topics) do
      add :title, :string

      timestamps()
    end

  end
end
