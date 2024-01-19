defmodule PromptCard do
  import SpeakWeb.CoreComponents
  use SpeakWeb, :live_component

  def mount(socket) do
    {:ok, socket |> assign(:is_read_only, true)}
  end

  def render(assigns) do
    ~H"""
      <div class="flex gap-x-4 items-center w-full max-w-3xl">
        <.input
          type="checkbox"
          phx-value-prompt-id={@prompt.id}
          name={"Enabled #{@prompt.id}"}
          value={@prompt.id}
          checked={@prompt.enabled}
          phx-click="prompt_toggled"
        />

        <.input
          placeholder={@prompt.message}
          type="text"
          name={@prompt.id}
          value={@prompt.message}
          wrapper_class="w-full"
          class={"border-none p-0 sm:text-base !mt-0"}
          phx-blur="prompt-on-edit"
          phx-value-id={@prompt.id}
          phx-value-old-content={@prompt.message}
        />

        <.simple_form class="flex items-center !mt-0" method="delete" action={~p"/prompts/#{@prompt.id}"} for={%{"id" => @prompt.id}}>
          <:actions>
            <.button
              class="bg-transparent flex items-center px-0 py-0 hover:bg-transparent focus:bg-transparent"
            >
              <span class="material-symbols-outlined text-red-400 hover:text-red-700 focus:text-red-700">delete</span>
            </.button>
          </:actions>
        </.simple_form>
      </div>
    """
  end
end
