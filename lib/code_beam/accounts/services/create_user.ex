defmodule CodeBeam.Accounts.Service.CreateUser do
  alias CodeBeam.Accounts
  require Logger

  def call(name) do
    with {:ok, user} <- Accounts.create_user(%{name: name}) do
      Logger.info("Yay a new user has registered!")
      user
    else
      _ ->
        Logger.error("KAPPOW!")
        :error
    end
  end
end
