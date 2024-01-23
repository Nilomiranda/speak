defmodule LectureForm do
  use SpeakWeb, :live_component

  def render(assigns) do
    ~H"""
      <div class="h-full">
        <h2 class="mb-10">New lecture</h2>

        <.simple_form
            for={@form}
            id="create_lecture_form"
            phx-submit="save"
            phx-trigger-action={@trigger_submit}
            action={~p"/lectures/new?_action=created&lecture_id=#{@lecture_id}"}
            method="post"
        >
            <.error :if={@check_errors}>
                Oops, something went wrong! Please check the errors below.
            </.error>

            <div class="flex items-center gap-x-4 w-full">
              <.input field={@form[:name]} label="Name" required wrapper_class="flex-1" />
              <.input field={@form[:description]} label="Description" wrapper_class="flex-1" />
            </div>

            <.input field={@form[:file]} type="file" label="Select an audio file" />

            <.input field={@form[:content]} label="Content" type="textarea" required class="h-[400px]" />

            <:actions>
                <.button phx-disable-with="Saving..." class="w-full">Save</.button>
            </:actions>
        </.simple_form>
      </div>
    """
  end
end
