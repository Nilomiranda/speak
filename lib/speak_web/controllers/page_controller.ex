defmodule SpeakWeb.PageController do
  use SpeakWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.

    conn
    |> put_layout(html: :dashboard)
    |> render(:home)
  end
end
