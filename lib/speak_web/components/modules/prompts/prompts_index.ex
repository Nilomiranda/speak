defmodule PromptsIndex do
  use SpeakWeb, :live_component

  def render(assigns) do
    ~H"""
      <div>
        <p class="mt-10">Prompts serve as instructions to exctract information from your lectures.</p>
        <strong>Totally tailored to your needs.</strong>

        <div class="w-full">
          <%= if length(@prompts) === 0 do %>
            <p class="mt-10">You don't have any prompts yet. <.link navigate={~p"/prompts/new"} class="text-brand hover:underline">Let's create a new one.</.link></p>
          <% end %>

          <%= if length(@prompts) > 0 do %>
            <strong class="flex items-center mt-6 mb-10">
              <span class="material-symbols-outlined text-brand">add</span>
              <.link navigate={~p"/prompts/new"} class="text-brand hover:underline">Create new</.link>
            </strong>
          <% end %>

          <%= for prompt <- @prompts do %>
            <div class="mb-6">
              <.live_component module={PromptCard} prompt={prompt} id={prompt.id} />
            </div>
          <% end %>
        </div>
      </div>
    """
  end
end
