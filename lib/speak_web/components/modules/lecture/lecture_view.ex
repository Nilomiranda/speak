defmodule LectureView do
  use SpeakWeb, :live_component

  def render(assigns) do
    ~H"""
      <div>
        <div class="flex items-start">
          <div class="flex flex-col">
            <h2><%= @lecture.name %></h2>
            <p><%= @lecture.description %></p>
          </div>

          <.simple_form class="flex items-center !mt-0" method="delete" action={~p"/lectures/#{@lecture.id}"} for={%{:id => @lecture.id}}>
            <:actions>
                <.button class="bg-transparent flex items-center px-0 py-0 ml-2 hover:bg-transparent focus:bg-transparent"><span class="material-symbols-outlined text-red-400 hover:text-red-700 focus:text-red-700">delete</span></.button>
            </:actions>
          </.simple_form>
        </div>

        <div class="flex items-stretch gap-x-2 mt-1 ">
          <div class="flex-1 p-1">
            <h3 class="text-brand text-xl mb-4">Content summary</h3>

            <%= case @lecture.summary_status do %>
              <% :processing -> %>
                <div class="flex items-center gap-x-4">
                  <span class="material-symbols-outlined animate-spin">sync</span>
                  <p>Processing summary, please refresh the page to check again</p>
                </div>
              <% :processed -> %>
                <p><%= raw @lecture.summary |> String.replace("\n", "<br />") %></p>
              <% :error -> %>
                <p>Error processing summary.</p>

                <!-- TODO: implement logic to reprocess summary -->
                <%!-- <.button phx-click="generate-summary" phx-value-content={@lecture.content}>Generate summary</.button> --%>
            <% end %>
          </div>

          <div class="flex-1 p-1">
            <p><%= raw @lecture.content |> String.replace("\n", "<br />") %></p>
          </div>

        </div>
      </div>
    """
  end
end
