defmodule CodeBeamWeb.PageController do
  use CodeBeamWeb, :controller

  alias CodeBeam.Handler.Registration

  def register(conn, %{ "q" => query}) do
    {user, marvel_details} = Registration.setup_user((query))
    render(conn, "register.json", %{user: user, details: marvel_details})
  end
end
