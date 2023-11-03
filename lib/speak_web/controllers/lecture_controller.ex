defmodule SpeakWeb.LectureController do
  use SpeakWeb, :controller

  alias Speak.Lectures

  def create(conn, %{"_action" => "created", "lecture_id" => lecture_id} = params) do
    Map.put(params, :lecture_id, lecture_id)
    create(conn, params, "Lecture created succesfully!")
  end

  def delete(conn, %{"id" => id}) do
    case Lectures.delete_by_id(id) do
      {:ok, _lecture} ->
        conn
        |> put_flash(:info, "Lecture deleted succesfully!")
        |> redirect(to: "/lectures")
      {:error, _changeset} ->
        conn
          |> put_flash(:error, "Couldn't delete lecture. Please try again")
          |> redirect(to: "/lectures")
    end
  end

  defp create(conn, %{"lecture_id" => lecture_id}, info) do
    if lecture = Lectures.get_by_id(lecture_id) do
      Task.start(fn -> Lectures.process_summary(lecture.content, lecture.id) end)

      conn
        |> put_flash(:info, info)
        |> Lectures.redirect_to_created_lecture(lecture.id)
    end
  end
end
