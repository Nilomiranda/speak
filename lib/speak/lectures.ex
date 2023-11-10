defmodule Speak.Lectures do
  import Phoenix.Controller
  import Ecto.Query, only: [from: 2]

  alias Speak.Repo
  alias Speak.Lecture
  alias Speak.OpenAI.OpenAI
  alias Speak.Prompts

  def get_by_user_id(user_id) when is_integer(user_id) do
    query = from lecture in Lecture, where: lecture.user_id == ^user_id
    Repo.all(query)
  end

  def get_by_id(id) do
    Repo.get_by(Lecture, id: id)
  end

  def save_lecture(attrs, user_id) do
    %{"name" => name, "content" => content, "description" => description} = attrs
    mapped_attributes = %{ :name => name, :content => content, :user_id => user_id, :description => description }

    %Lecture{}
    |> Lecture.changeset(mapped_attributes)
    |> Repo.insert()
  end

  defp save_summary_to_lecture(id, nil) do
    lecture = Repo.get!(Lecture, id)
    lecture = Lecture.changeset(lecture, %{:summary_status => :error})

    lecture |> Repo.update
  end

  defp save_summary_to_lecture(id, summary) when is_binary(summary) do
    IO.inspect "Generated summary for lecture id #{id}"

    lecture = Repo.get!(Lecture, id)
    lecture = Lecture.changeset(lecture, %{:summary_status => :processed, :summary => summary})

    lecture |> Repo.update
  end

  def process_summary(lecture_content, lecture_id, user_id) when is_binary(lecture_content) do
    prompts = Prompts.get_enabled_and_by_user_id(user_id)

    ## TODO: improve this control flow if user doesn't have any enabled prompt

    unless length(prompts) == 0 do
      prompts_messages = Enum.map(prompts, fn prompt -> prompt.message end)

      case OpenAI.send_gtp_request(lecture_content, lecture_id, prompts_messages) do
        {:ok, generated_summary} ->
          save_summary_to_lecture(lecture_id, generated_summary)
        {:error, error} ->
          IO.puts "Error processing summary for lecture id #{lecture_id}"
          IO.puts error
          save_summary_to_lecture(lecture_id, nil)
        {:unexpected_error, exception} ->
          IO.puts "Unexpected error processing summary for lecture id #{lecture_id}"
          IO.puts exception
          save_summary_to_lecture(lecture_id, nil)
      end
    end
  end

  def delete_by_id(id) do
    lecture_to_delete = Repo.get_by(Lecture, id: id);

    lecture_to_delete |> Repo.delete()
  end

  def change_lecture_creation(%Lecture{} = lecture, attrs \\ %{}) do
    Lecture.changeset(lecture, attrs)
  end

  def redirect_to_created_lecture(conn, lecture_id) do
    conn |> redirect(to: "/lectures/#{lecture_id}")
  end
end
