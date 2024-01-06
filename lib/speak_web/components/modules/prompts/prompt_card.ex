defmodule PromptComponents do
  import SpeakWeb.CoreComponents
  use Phoenix.Component

  attr :prompt, Speak.Prompt, required: true
  def prompt_card(assigns) do
    ~H"""
      <div>
        <.input
          type="text"
          name={@prompt.id}
          value={@prompt.message}
          class="border-none p-0 sm:text-base"
          />

          <p
            class="text-base"
            @blur="alert('hi')"
            phx-blur="prompt-blurred"
            phx-value-id={@prompt.message}
            >
              <%= @prompt.message %>
          </p>
      </div>
    """
  end
end
