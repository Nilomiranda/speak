defmodule Speak.Repo.Migrations.AddEnabledToPrompts do
  use Ecto.Migration

  def change do
    alter table "prompts" do
      add :enabled, :boolean, default: true
    end
  end
end
