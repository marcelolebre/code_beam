defmodule CodeBeam.Handler.Registration do
  alias CodeBeam.Accounts.Service.{CreateUser, SendRegistrationEmail}

  def setup_user(name) do
    with {:ok, user} <- CreateUser.call(name),
         :ok <- SendNotification.call(user) do
      user
    else
      error ->
        error
    end
  end

  def validate_user() do
  end

  def delete_user() do
  end
end
