defmodule SpeakWeb.PromptController do
  use SpeakWeb, :controller

  alias Speak.Prompts

  def create(conn, %{"_action" => "created", "prompt_id" => prompt_id}) do
    create(conn, %{:prompt_id => prompt_id}, "Lecture created succesfully!")
  end

  defp create(conn, %{:prompt_id => prompt_id}, info) do
    if Prompts.get_by_id(prompt_id) do
      conn
        |> put_flash(:info, info)
        |> redirect(to: "/prompts")
    end
  end
end
