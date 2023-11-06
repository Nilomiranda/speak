defmodule Speak.Prompt do
  use Ecto.Schema
  import Ecto.Changeset

  schema "prompts" do
    field :message, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(prompt, attrs) do
    prompt
    |> cast(attrs, [:message])
    |> validate_required([:message])
  end
end
