defmodule CodeBeam.Handler.Registration do
  alias CodeBeam.Service.{CreateUser, SendRegistrationEmail}

  def setup_user(user_params) do
    with {:ok, user} <- CreateUser.call(user_params),
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
