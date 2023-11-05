defmodule PromptsIndex do
  use SpeakWeb, :live_component

  def render(assigns) do
    ~H"""
      <div class="mb-10">
        <h1>Prompts</h1>
        <p>Prompts serve as instructions to exctract information from your lectures.</p>
        <strong>Totally tailored to your needs.</strong>
      </div>
    """
  end
end
