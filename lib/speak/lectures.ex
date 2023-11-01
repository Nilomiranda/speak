defmodule Speak.Lectures do
  import Phoenix.Controller

  alias Speak.Repo
  alias Speak.Lecture

  def get_by_user_id(user_id) when is_integer(user_id) do
    Repo.all(Lecture, user_id: user_id)
  end

  def get_by_id(id) do
    Repo.get_by(Lecture, id: id)
  end

  def save_lecture(attrs, user_id) do
    %{"name" => name, "content" => content, "description" => description} = attrs
    mapped_attributes = %{ :name => name, :content => content, :user_id => user_id, :description => description }

    %Lecture{}
    |> Lecture.changeset(mapped_attributes)
    |> Repo.insert()
  end

  def delete_by_id(id) do
    lecture_to_delete = Repo.get_by(Lecture, id: id);

    lecture_to_delete |> Repo.delete()
  end

  def change_lecture_creation(%Lecture{} = lecture, attrs \\ %{}) do
    Lecture.changeset(lecture, attrs)
  end

  def redirect_to_created_lecture(conn, lecture_id) do
    conn |> redirect(to: "/lectures/#{lecture_id}")
  end
end
