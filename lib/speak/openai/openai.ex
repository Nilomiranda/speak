defmodule Speak.OpenAI.OpenAI do
  import HTTPoison
  alias HTTPoison

  alias Speak.Utils

  def send_gtp_request(content_to_query_about, lecture_id) do
    IO.inspect "Handling summary generation for lecture id #{lecture_id}"
    open_ai_base_completions_url = "https://api.openai.com/v1/chat/completions"
    open_ai_token = System.get_env "OPEN_AI_API_KEY"

    default_prompts = [
      "What is this text about?",
      "What are other topics that could further extend what is discussed in this text",
      "Are there citations to scientific articles? If so, outline these articles in comma separated values"
    ]

    instruction_list = Enum.join(default_prompts, "{INSTRUCTION}")
    messages = [
      %{
        "role" => "user",
        "content" => "
          You are a university teacher, and given the following text #{content_to_query_about}, follow these instructions that start with '{INSTRUCTION}' and ends when the next '{INSTRUCTION}' comes: #{instruction_list}.
        "
      }
    ]

    body = %{
      "messages" => messages,
      "model" => "gpt-3.5-turbo",
    }

    headers = %{
      "Content-Type" => "application/json",
      "Authorization" => "Bearer #{open_ai_token}"
    }

    encoded_body = Utils.encode_json(body)

    IO.inspect "About to send request to Open AI..."
    case request(:post, open_ai_base_completions_url, encoded_body, headers, [recv_timeout: 600000]) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        # TODO: improve error handling
        decoded_body = Utils.decode_json(body)

        %{"choices" => choices} = decoded_body
        %{"message" => %{"content" => content}} = hd choices

        {:ok, content}
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, "Not found"}
      {:ok, %HTTPoison.Response{status_code: 429}} ->
        {:error, "Not enough credits"}
      {:ok, %HTTPoison.Response{status_code: status_code}} ->
        {:unexpected_error, "Received status #{status_code}"}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:unexpected_error, reason}
    end
  end
end
