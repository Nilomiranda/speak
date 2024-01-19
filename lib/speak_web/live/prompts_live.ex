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

  def handle_event("prompt_toggled", %{"prompt-id" => prompt_id}, socket) do
    case Prompts.disable_by_id_and_user_id(prompt_id, socket.assigns.current_user.id) do
      {:ok} ->
        {:noreply, socket |> put_flash(:info, "Preferences succesfully saved.")}
      {:error} ->
        {:noreply, socket |> put_flash(:error, "Couldn't save your preferences. Please try again.")}
    end
  end

  def handle_event("edited", %{"id" => prompt_id, "value" => updated_value, "old-content" => old_content}, socket) do
    unless old_content === updated_value do
      case Prompts.update_message_by_user_and_prompt_id(prompt_id, socket.assigns.current_user.id, updated_value) do
        {:ok} ->
          {:noreply, socket |> put_flash(:info, "Prompt updated successfully.")}
        {:error} ->
          {:noreply, socket |> put_flash(:error, "Couldn't update prompt. Please try again.")}
      end
    end

    {:noreply, socket}
  end

  def handle_event("edited", _params, socket) do
    # This handles the phx-submit="edited"
    # When form is submitted with enter
    # The input's blur event trigger, which is handled by the
    # function above, so edition save is already taken care of
    # Nothing needs to happen in this action from the form submission anymore

    {:noreply, socket}
  end
end
