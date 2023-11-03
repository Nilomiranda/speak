defmodule SpeakWeb.LecturesLive do
  use SpeakWeb, :live_view

  alias Speak.Lectures
  alias Speak.Lecture

  @poll_interval 5_000

  defp schedule_poll(lecture_id) do
    Process.send_after(self(), {:poll, lecture_id}, @poll_interval)
  end

  def mount(%{"id" => id}, _session, %{:assigns => %{:live_action => :show}} = socket) do
    if connected?(socket) do
      schedule_poll(id)
    end

    {
      :ok,
      socket
        |> assign(:summary_response, "")
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

  def handle_info({:poll, lecture_id}, socket) do
    lecture_with_summary = fetch_lecture(lecture_id)

    if lecture_with_summary.summary_status === :processing do
      schedule_poll(lecture_id)
    end

    {:noreply, socket |> assign(:lecture, lecture_with_summary)}
  end

  # def handle_event("generate-summary", %{"content" => lecture_content}, socket) do
  #   # TODO: change this to dynamic values once user can create prompts
  #   default_prompts = [
  #     "What is this text about?",
  #     "What are other topics that could further extend what is discussed in this text",
  #     "Are there citations to scientific articles? If so, outline these articles in comma separated values"
  #   ]

  #   case OpenAI.send_gtp_request(default_prompts, lecture_content) do
  #     {:ok, response} ->
  #       {:noreply, socket |> assign(:summary_response, response)}
  #     {:error, error} ->
  #       {:noreply, socket |> put_flash(:error, error)}
  #     {:unexpected_error, unexpected_error} ->
  #       {:noreply, socket |> put_flash(:error, unexpected_error)}
  #   end
  # end
end
