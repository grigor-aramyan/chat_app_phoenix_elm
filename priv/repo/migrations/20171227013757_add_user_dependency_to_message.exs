defmodule ChatApp.Repo.Migrations.AddUserDependencyToMessage do
  use Ecto.Migration

  def change do
    alter table (:messages) do
      add :user_id, references(:users)
    end
  end
end
