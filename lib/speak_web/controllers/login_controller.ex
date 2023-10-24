defmodule SpeakWeb.LoginController do
  use SpeakWeb, :controller

  def index(conn, _params) do
    render(conn, :index, layout: false)
  end
end
