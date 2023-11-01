defmodule SpeakWeb.LecturesLive do
  use SpeakWeb, :live_view

  alias Speak.Lectures
  alias Speak.Lecture

  def mount(%{"id" => id}, _session, %{:assigns => %{:live_action => :show}} = socket) do
    {
      :ok,
      socket
        |> assign(:lecture, fetch_lecture(id)),
        layout: {SpeakWeb.Layouts, :dashboard}
    }
  end

  def mount(_params, _session, socket) do
    changeset = Lectures.change_lecture_creation(%Lecture{})

    {
      :ok,
      socket
        |> assign(trigger_submit: false, check_errors: false, lecture_id: "")
        |> assign(:lectures, fetch_lectures(socket))
        |> assign_form(changeset),
      layout: {SpeakWeb.Layouts, :dashboard}
    }
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    form = to_form(changeset, as: "lecture")

    if changeset.valid? do
      assign(socket, form: form, check_errors: false)
    else
      assign(socket, form: form)
    end
  end

  defp fetch_lectures(socket) do
    fetched_lectures = Lectures.get_by_user_id(socket.assigns.current_user.id)
    IO.inspect("fetched_lectures")
    IO.inspect(fetched_lectures)
    fetched_lectures
  end

  defp fetch_lecture(lecture_id) do
    fetched_lecture = Lectures.get_by_id(lecture_id)

    fetched_lecture
  end

  def handle_event("save", %{"lecture" => lecture_params}, socket) do
    case Lectures.save_lecture(lecture_params, socket.assigns.current_user.id) do
      {:ok, lecture} ->
        changeset = Lectures.change_lecture_creation(lecture)
        {:noreply, socket |> assign(trigger_submit: true, lecture_id: lecture.id) |> assign_form(changeset)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, socket |> assign(check_errors: true) |> assign_form(changeset)}
    end
  end
end
