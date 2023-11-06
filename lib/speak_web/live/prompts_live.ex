defmodule SpeakWeb.PromptsLive do
  use SpeakWeb, :live_view

  alias Speak.Prompts

  def mount(_params, _session, socket) do
    {
      :ok,
      socket
        |> assign(:prompts, fetch_prompts(socket)),
      layout: {SpeakWeb.Layouts, :dashboard}
    }
  end

  defp fetch_prompts(socket) do
    Prompts.get_by_user_id(socket.assigns.current_user.id)
  end
end
