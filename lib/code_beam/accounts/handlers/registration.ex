defmodule CodeBeam.Handler.Registration do
  alias CodeBeam.Accounts.Service.{CreateUser, SendRegistrationEmail}

  def setup_user(name) do
    with {:ok, user} <- CreateUser.call(name),
         :ok <- SendRegistrationEmail.call(user) do
      user
    else
      {:error, :invalid_params} ->
        IO.inspect(:invalid_params)

      {:error, :failed_email} ->
        IO.inspect(:invalid_params)

      error ->
        IO.inspect(error)
    end
  end

  def validate_user() do
  end

  def delete_user() do
  end
end
