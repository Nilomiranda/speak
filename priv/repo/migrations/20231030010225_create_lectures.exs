defmodule Speak.Repo.Migrations.CreateLectures do
  use Ecto.Migration

  def change do
    create table(:lectures) do
      add :name, :string
      add :content, :text
      add :user_id, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:lectures, [:user_id])
  end
end
