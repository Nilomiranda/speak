defmodule Speak.Lecture do
  use Ecto.Schema
  import Ecto.Changeset

  schema "lectures" do
    field :name, :string
    field :content, :string
    field :user_id, :id

    timestamps()
  end

  @doc false
  def changeset(lecture, attrs) do
    lecture
    |> cast(attrs, [:name, :content])
    |> validate_required([:name, :content])
  end
end