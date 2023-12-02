defmodule Speak.Repo.Migrations.CreatePrompts do
  use Ecto.Migration

  def change do
    create table(:prompts) do
      add :message, :string
      add :enabled, :boolean, default: true
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:prompts, [:user_id])
  end
end
