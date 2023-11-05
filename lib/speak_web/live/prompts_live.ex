defmodule SpeakWeb.PromptsLive do
  use SpeakWeb, :live_view

  def mount(_params, _session, socket) do
    {
      :ok,
      socket,
      layout: {SpeakWeb.Layouts, :dashboard}
    }
  end
end
