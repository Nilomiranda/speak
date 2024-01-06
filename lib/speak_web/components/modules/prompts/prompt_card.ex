defmodule PromptCard do
  import SpeakWeb.CoreComponents
  use SpeakWeb, :live_component

  def render(assigns) do
    ~H"""
      <div>
        <.input
          phx-click="clicked-prompt-card"
          type="text"
          name={@prompt.id}
          value={@prompt.message}
          class="border-none p-0 sm:text-base"
        />

          <p
            phx-clicks="clicked-prompt-card"
            class="text-base"
            phx-blur="prompt-blurred"
            phx-value-id={@prompt.message}
            >
              <%= @prompt.message %>
          </p>
      </div>
    """
  end
end
