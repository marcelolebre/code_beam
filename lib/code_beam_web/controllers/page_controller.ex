defmodule CodeBeamWeb.PageController do
  use CodeBeamWeb, :controller

  alias CodeBeam.Handler.Registration
  alias CodeBeam.Accounts.Finder.SuperHeroName

  alias CodeBeam.Accounts

  require Logger

  def register(conn, %{"q" => query}) do
    {user, marvel_details} = Registration.setup_user(query)
    render(conn, "register.json", %{user: user, details: marvel_details})
  end

  def register2(conn, %{"q" => query}) do
    with {:ok, user} <- Accounts.create_user(%{name: query}) do
      Logger.info("New user created on #{DateTime.utc_now()}")

      Logger.info("Notification sent to #{user.name}")

      super_hero_details = SuperHeroName.find2(query)

      results =
        Map.merge(%{}, %{id: user.id})
        |> Map.merge(%{name: user.name})
        |> Map.merge(super_hero_details)

      json(conn, results)
    else
      {:error, %Ecto.Changeset{} = changeset} ->
        {:error, {:invalid_params, changeset.errors}}

      error ->
        error
    end
  end
end
