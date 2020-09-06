defmodule CodeBeam.Accounts.Service.CreateUser do
  alias CodeBeam.Accounts
  alias CodeBeam.Service.ActivityLog
  require Logger

  def call(name) do
    with {:ok, user} <- Accounts.create_user(%{name: name}),
         :ok <- ActivityLog.call(:create_user) do
      {:ok, user}
    else
      {:error, %Ecto.Changeset{} = changeset} ->
        {:error, {:invalid_params, changeset.errors}}

      error ->
        error
    end
  end
end
