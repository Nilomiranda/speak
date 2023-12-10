defmodule PromptsIndex do
  use SpeakWeb, :live_component

  def render(assigns) do
    ~H"""
      <div>
        <p class="mt-10">Prompts serve as instructions to exctract information from your lectures.</p>
        <strong>Totally tailored to your needs.</strong>

        <div>
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
            <div class="flex items-center gap-x-4 mb-6">
              <span contenteditable="true" phx-blur="prompt_blurred" phx-value-id={prompt.message}><%= prompt.message %></span>

              <.input
                type="checkbox"
                phx-value-prompt-id={prompt.id}
                name={"Enabled #{prompt.id}"}
                value={prompt.id}
                checked={prompt.enabled}
                phx-click="prompt_toggled"
              />

              <.simple_form class="flex items-center !mt-0" method="delete" action={~p"/prompts/#{prompt.id}"} for={%{"id" => prompt.id}}>
                <:actions>
                    <.button
                      class="bg-transparent flex items-center px-0 py-0 hover:bg-transparent focus:bg-transparent"
                    >
                      <span class="material-symbols-outlined text-red-400 hover:text-red-700 focus:text-red-700">delete</span>
                    </.button>
                </:actions>
              </.simple_form>
            </div>
          <% end %>
        </div>
      </div>
    """
  end
end
