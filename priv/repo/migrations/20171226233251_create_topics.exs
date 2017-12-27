defmodule ChatApp.Repo.Migrations.CreateTopics do
  use Ecto.Migration

  def change do
    create table(:topics) do
      add :title, :string
      add :message_count, :integer

      timestamps()
    end

  end
end
