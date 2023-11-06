defmodule PromptsIndex do
  use SpeakWeb, :live_component

  def render(assigns) do
    ~H"""
      <div>
        <h1 class="mb-4">Prompts</h1>
        <p >Prompts serve as instructions to exctract information from your lectures.</p>
        <strong>Totally tailored to your needs.</strong>

        <div class="mt-10">
          <%= if length(@prompts) === 0 do %>
            <p>You don't have any prompts yet. Let's create a few.</p>
          <% end %>

          <%= for {prompt, index} <- Enum.with_index(@prompts) do %>
            <div class="flex items-center gap-x-4 mb-6">
              <p><%= prompt.message %></p>

              <.input type="checkbox" name={"Enabled #{prompt.id}"} value={prompt.id} checked={prompt.enabled} />
            </div>
          <% end %>
        </div>
      </div>
    """
  end
end
