defmodule SpeakWeb.LectureController do
  use SpeakWeb, :controller

  alias Speak.Lectures

  def create(conn, %{"_action" => "created", "lecture_id" => lecture_id} = params) do
    Map.put(params, :lecture_id, lecture_id)
    create(conn, params, "Lecture created succesfully!")
  end

  defp create(conn, %{"lecture_id" => lecture_id}, info) do
    if lecture = Lectures.get_by_id(lecture_id) do
      conn
        |> put_flash(:info, info)
        |> Lectures.redirect_to_created_lecture(lecture.id)
    end
  end
end
