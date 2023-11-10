defmodule PromptForm do
  use SpeakWeb, :live_component

  def render(assigns) do
    ~H"""
      <div class="h-full">
        <h2 class="mt-6 mb-10">New prompt</h2>

        <.simple_form
            for={@form}
            id="create_prompt_form"
            phx-submit="save"
            phx-trigger-action={@trigger_submit}
            action={~p"/prompts/new?_action=created&prompt_id=#{@prompt_id}"}
            method="post"
            class="w-full max-w-lg"
        >
            <.error :if={@check_errors}>
                Oops, something went wrong! Please check the errors below.
            </.error>

            <.input field={@form[:message]} label="Instruction" required wrapper_class="flex-1" />

            <:actions>
                <.button phx-disable-with="Saving..." class="w-full">Save</.button>
            </:actions>
        </.simple_form>
      </div>
    """
  end
end
