defmodule CodeBeamWeb.PageController do
  use CodeBeamWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
