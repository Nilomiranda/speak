defmodule Speak.Lectures do
  alias Speak.Repo
  alias Speak.Lecture

  def get_by_user_id(user_id) when is_integer(user_id) do
    Repo.get_by(Lecture, user_id: user_id)
  end
end
