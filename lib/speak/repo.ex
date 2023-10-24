defmodule Speak.Repo do
  use Ecto.Repo,
    otp_app: :speak,
    adapter: Ecto.Adapters.Postgres
end
