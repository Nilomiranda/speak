defmodule SpeakWeb.HomeLive do
  use SpeakWeb, :live_view

  def render(%{live_action: :show} = assigns) do
    ~H"""
      <h1>This is the dashboard</h1>
    """
  end
end
