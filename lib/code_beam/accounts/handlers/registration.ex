defmodule CodeBeam.Handler.Registration do
  alias CodeBeam.Accounts.Service.{CreateUser, SendNotification}
  alias CodeBeam.Accounts.Finder.SuperHeroName

  def setup_user(name) do
    with {:ok, user} <- CreateUser.call(name),
         :ok <- SendNotification.call(user),
         super_hero_details <- SuperHeroName.find(name) do
      {user, super_hero_details}
    else
      error ->
        error
    end
  end
end
