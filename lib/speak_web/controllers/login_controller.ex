defmodule SpeakWeb.LoginController do
  use SpeakWeb, :controller

  def login(conn, _params) do
    render(conn, :login, layout: false)
  end
end
