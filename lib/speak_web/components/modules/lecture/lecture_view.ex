defmodule LectureView do
  use SpeakWeb, :live_component

  def render(assigns) do
    ~H"""
      <div>
        <div class="flex items-center">
          <h2><%= @lecture.name %></h2>

          <.simple_form class="flex items-center !mt-0" method="delete" action={~p"/lectures/#{@lecture.id}"} for={%{:id => @lecture.id}}>
            <:actions>
                <.button class="bg-transparent flex items-center px-0 py-0 ml-2 hover:bg-transparent focus:bg-transparent"><span class="material-symbols-outlined text-red-400 hover:text-red-700 focus:text-red-700">delete</span></.button>
            </:actions>
          </.simple_form>
        </div>

        <p><%= @lecture.description %></p>

        <p><%= @lecture.content %></p>
      </div>
    """
  end
end
