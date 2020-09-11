defmodule Benchmark do

  alias CodeBeam.Handler.Registration
  alias CodeBeam.Accounts.Finder.SuperHeroName
  alias CodeBeam.Value
  alias CodeBeam.Accounts

  alias CodeBeam.Value.Registration, as: RegistrationValue

  require Logger

  def run_srp() do
    Benchee.run(
      %{
        "run_srp" => fn -> srp() end
      }
    )
  end

  def run_extended() do
    Benchee.run(
      %{
        "run_extended" => fn -> extended() end
      }
    )
  end

  def run_value() do
    user = Accounts.get_user!(1)
    hero = SuperHeroName.find2("Hulk")

    Benchee.run(
      %{
        "call" => fn -> value_srp(user, hero) end
      }
    )
  end

  def run_value_extended() do
    user = Accounts.get_user!(1)
    hero = SuperHeroName.find2("Hulk")

    Benchee.run(
      %{
        "call1" => fn -> value_extended(user, hero) end
      }
    )
  end

  def srp() do
    {user, marvel_details} = Registration.setup_user("Hulk")

    RegistrationValue.build(user, marvel_details)
  end

  def extended() do
    with {:ok, user} <- Accounts.create_user(%{name: "Hulk"}) do
      Logger.info("New user created on #{DateTime.utc_now()}")

      Logger.info("Notification sent to #{user.name}")

      super_hero_details = SuperHeroName.find2("Hulk")

      Map.merge(%{}, %{id: user.id})
        |> Map.merge(%{name: user.name})
        |> Map.merge(super_hero_details)

    else
      {:error, %Ecto.Changeset{} = changeset} ->
        {:error, {:invalid_params, changeset.errors}}

      error ->
        error
    end
  end



  defp value_srp(user, hero) do
    Value.init(user)
    |> Value.only([:name, :id])
    |> Value.add(hero)
  end

  defp value_extended(user, hero) do
    Map.merge(%{}, %{id: user.id})
    |> Map.merge(%{name: user.name})
    |> Map.merge(hero)
  end
end
