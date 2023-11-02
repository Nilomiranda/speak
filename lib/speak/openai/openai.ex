defmodule Speak.OpenAI.OpenAI do
  use HTTPoison.Base

  alias Speak.Utils

  import Poison

  def send_gtp_request(query, content_to_query_about) do
    open_ai_base_completions_url = "https://api.openai.com/v1/chat/completions"
    open_ai_token = System.get_env "OPEN_AI_API_KEY"

    instruction_list = Enum.join(query, "{INSTRUCTION}")
    messages = [
      %{
        "role" => "user",
        "content" => "You are a university teacher, and given the following text #{content_to_query_about}, follow these instructions that start with '{INSTRUCTION}' and ends when the next '{INSTRUCTION}' comes: #{instruction_list}."
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

    case HTTPoison.request(:post, open_ai_base_completions_url, encoded_body, headers, [recv_timeout: 600000]) do
      {:ok, %HTTPoison.Response{status_code: 200, body: body}} ->
        # TODO: improve error handling
        IO.puts "response body"
        IO.puts body

        decoded_body = Utils.decode_json(body)

        %{"choices" => choices} = decoded_body
        %{"message" => %{"content" => content}} = hd choices

        {:ok, content}
      {:ok, %HTTPoison.Response{status_code: 404}} ->
        {:error, "Not fount"}
      {:ok, %HTTPoison.Response{status_code: 429}} ->
        {:error, "Not enough credits"}
      {:error, %HTTPoison.Error{reason: reason}} ->
        {:unexpected_error, reason}
    end
  end
end
