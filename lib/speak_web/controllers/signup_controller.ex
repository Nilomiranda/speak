defmodule SpeakWeb.SignUpController do
  use SpeakWeb, :controller

  def index(conn, _params) do
    render(conn, :index, layout: false)
  end

  def create(conn, params) do
    %{ "email" => email, "password" => password, "name" => name } = params
    IO.inspect(email)
    IO.inspect(password)
    IO.inspect(name)

    conn
  end
end
