defmodule SpeakWeb.PromptsLive do
  use SpeakWeb, :live_view

  alias Speak.Prompts
  alias Speak.Prompt

  def mount(_params, _session, socket) do
    changeset = Prompts.change_prompt_creation(%Prompt{})

    {
      :ok,
      socket
        |> assign(trigger_submit: false, check_errors: false, prompt_id: "")
        |> assign(:prompts, fetch_prompts(socket))
        |> assign_form(changeset),
      layout: {SpeakWeb.Layouts, :dashboard}
    }
  end

  defp assign_form(socket, %Ecto.Changeset{} = changeset) do
    form = to_form(changeset, as: "prompt")

    if changeset.valid? do
      assign(socket, form: form, check_errors: false)
    else
      assign(socket, form: form)
    end
  end

  defp fetch_prompts(socket) do
    Prompts.get_by_user_id(socket.assigns.current_user.id)
  end

  def handle_event("save", %{"prompt" => prompt_params}, socket) do
    case Prompts.save_prompt(prompt_params, socket.assigns.current_user.id) do
      {:ok, prompt} ->
        changeset = Prompts.change_prompt_creation(prompt)
        {:noreply, socket |> assign(trigger_submit: true, prompt_id: prompt.id) |> assign_form(changeset)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, socket |> assign(check_errors: true) |> assign_form(changeset)}
    end
  end
end
