defmodule Speak.Lecture do
  use Ecto.Schema
  import Ecto.Changeset

  schema "lectures" do
    field :name, :string
    field :content, :string
    field :description, :string
    field :user_id, :id
    field :summary, :string
    field :summary_status, Ecto.Enum, values: [:processing, :processed, :error], default: :processing

    timestamps()
  end

  @doc false
  def changeset(lecture, attrs) do
    lecture
    |> cast(attrs, [:name, :content, :user_id, :description])
    |> validate_required([:name, :content, :user_id])
  end
end
