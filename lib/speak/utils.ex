defmodule Speak.Utils do
  import Poison

  @doc """
    Attempts to encode a map to a JSON.
    In case it fails to encode, returns original map
  """
  def encode_json(data) do
    case encode data do
      {:ok, encoded} -> encoded

      {:error, error} ->
        IO.inspect("Attempted to encode the following JSON failed.")
        IO.inspect(data)
        IO.inspect("Failed for the following reason:")
        IO.inspect(error)

        data
    end
  end

  @doc """
    Attempts to decode a JSON into a valid map.
    In case it fails to decode, returns original encoded JSON
  """
  def decode_json(encoded_json) do
    case decode encoded_json do
      {:ok, decoded_body} -> decoded_body

      {:error, error} ->
        IO.inspect("Attempted to decode the following JSON failed.")
        IO.inspect(encoded_json)
        IO.inspect("Failed for the following reason:")
        IO.inspect(error)
        encoded_json
    end
  end
end
