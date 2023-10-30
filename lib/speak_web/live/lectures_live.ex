defmodule SpeakWeb.LecturesLive do
  use SpeakWeb, :live_view

  alias Speak.Lectures

  def mount(_params, _session, socket) do
    {
      :ok,
      socket
        |> assign(:lectures, fetch_lectures(socket)),
      layout: {SpeakWeb.Layouts, :dashboard}
    }
  end

  defp fetch_lectures(socket) do
    fetched_lectures = Lectures.get_by_user_id(socket.assigns.current_user.id)

    fetched_lectures
  end
end
