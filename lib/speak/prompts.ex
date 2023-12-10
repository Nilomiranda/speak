defmodule Speak.Prompts do
  alias Speak.Prompt
  alias Speak.Repo
  alias Ecto

  import Ecto.Query, only: [from: 2]


  def get_by_user_id(user_id) do
    query = from prompt in Prompt, where: prompt.user_id == ^user_id
    Repo.all(query)
  end

  def get_enabled_and_by_user_id(user_id) do
    query = from prompt in Prompt, where: prompt.user_id == ^user_id and prompt.enabled == true
    prompts = Repo.all(query)
    prompts
  end

  def disable_by_id_and_user_id(prompt_id, user_id) do
    query = from prompt in Prompt, where: prompt.user_id == ^user_id and prompt.id == ^prompt_id
    prompt = query |> Repo.one

    updated_prompt = Ecto.Changeset.change prompt, enabled: !prompt.enabled

    case Repo.update updated_prompt do
      {:ok, _struct} -> {:ok}
      {:error, _changeset} -> {:error}
    end
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

  def change_prompt_creation(%Prompt{} = prompt, attrs \\ %{}) do
    Prompt.changeset(prompt, attrs)
  end

  def save_prompt(attrs, user_id) do
    %{"message" => message} = attrs
    mapped_attributes = %{:message => message, :user_id => user_id}

    %Prompt{}
    |> Prompt.changeset(mapped_attributes)
    |> Repo.insert()
  end

  def get_by_id(prompt_id) do
    Prompt |> Repo.get_by(id: prompt_id)
  end

  def delete_by_id(id) do
    prompt_to_delete = Repo.get_by(Prompt, id: id);

    prompt_to_delete |> Repo.delete()
  end
end
