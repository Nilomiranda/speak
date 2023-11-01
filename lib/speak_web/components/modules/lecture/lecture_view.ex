defmodule LectureView do
  use SpeakWeb, :live_component

  def render(assigns) do
    ~H"""
      <div>
        <h2><%= @lecture.name %></h2>

        <p><%= @lecture.content %></p>
      </div>
    """
  end
end
