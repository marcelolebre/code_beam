defmodule CodeBeamWeb.PageView do
  use CodeBeamWeb, :view

  alias CodeBeam.Value.Registration

  def render("register.json", %{user: user, details: marvel_details}) do
    Registration.build(user, marvel_details)
  end
end
