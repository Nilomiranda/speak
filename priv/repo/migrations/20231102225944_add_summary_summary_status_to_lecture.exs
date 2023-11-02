defmodule Speak.Repo.Migrations.AddNameFieldToUser do
  use Ecto.Migration

  def change do
    alter table("lectures") do
      add :summary, :text
      add :summary_status, :text
    end
  end
end
