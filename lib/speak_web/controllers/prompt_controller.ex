defmodule SpeakWeb.PromptController do
  use SpeakWeb, :controller

  alias Speak.Prompts

  def create(conn, %{"_action" => "created", "prompt_id" => prompt_id}) do
    create(conn, %{:prompt_id => prompt_id}, "Lecture created succesfully!")
  end

  def delete(conn, %{"id" => id}) do
    case Prompts.delete_by_id(id) do
      {:ok, _prompt} ->
        conn
        |> put_flash(:info, "Prompt deleted succesfully!")
        |> redirect(to: "/prompts")
      {:error, _changeset} ->
        conn
          |> put_flash(:error, "Couldn't delete prompt. Please try again")
          |> redirect(to: "/prompts")
    end
  end

  defp create(conn, %{:prompt_id => prompt_id}, info) do
    if Prompts.get_by_id(prompt_id) do
      conn
        |> put_flash(:info, info)
        |> redirect(to: "/prompts")
    end
  end
end
