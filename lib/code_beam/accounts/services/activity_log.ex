defmodule CodeBeam.Service.ActivityLog do
  require Logger

  def call(:create_user) do
    Logger.info("New user created on #{DateTime.utc_now()}")
  end
end
