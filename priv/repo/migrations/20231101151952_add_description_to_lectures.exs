defmodule Speak.Repo.Migrations.AddNameFieldToUser do
  use Ecto.Migration

  def change do
    alter table("lectures") do
      add :description, :string
    end
  end
end
