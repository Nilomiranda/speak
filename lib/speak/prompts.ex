defmodule Speak.Prompts do
  alias Speak.Prompt
  alias Speak.Repo

  import Ecto.Query, only: [from: 2]


  def get_by_user_id(user_id) do
    query = from prompt in Prompt, where: prompt.user_id == ^user_id
    Repo.all(query)
  end

  def add_defaults_to_user_id(user_id) do
    system_default_prompts = [
      "What is this text about?",
      "What are other topics that could further extend what is discussed in this text?",
      "Are there citations to scientific articles? If so, outline these articles in bullet points."
    ]

    current_timestamp = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)

    default_prompts_changeset = Enum.map(system_default_prompts, fn default_prompt ->
      %{message: default_prompt, enabled: true, user_id: user_id, inserted_at: current_timestamp, updated_at: current_timestamp}
    end)

    Repo.insert_all(Prompt, default_prompts_changeset)
  end
end
