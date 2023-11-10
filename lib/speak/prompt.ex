defmodule Speak.Prompt do
  use Ecto.Schema
  import Ecto.Changeset

  schema "prompts" do
    field :message, :string
    field :enabled, :boolean, default: true
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(prompt, attrs) do
    prompt
    |> cast(attrs, [:message, :enabled, :user_id])
    |> validate_required([:message, :user_id])
    |> validate_length(:message, max: 200)
  end
end
