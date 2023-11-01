defmodule LectureForm do
  use SpeakWeb, :live_component

  def render(assigns) do
    ~H"""
      <div>
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

            <.input field={@form[:name]} label="Name" required />
            <.input field={@form[:description]} label="Description" />
            <.input field={@form[:content]} label="Content" type="textarea" required />

            <:actions>
                <.button phx-disable-with="Saving..." class="w-full">Save</.button>
            </:actions>
        </.simple_form>
      </div>
    """
  end
end
