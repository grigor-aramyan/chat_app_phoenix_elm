defmodule ChatApp.Repo.Migrations.CreateMessages do
  use Ecto.Migration

  def change do
    create table(:messages) do
      add :body, :string
      add :topic_id, references(:topics, on_delete: :nothing)

      timestamps()
    end

    create index(:messages, [:topic_id])
  end
end
