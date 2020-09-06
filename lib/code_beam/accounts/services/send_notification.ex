defmodule CodeBeam.Accounts.Service.SendNotification do
  require Logger

  def call(user) do
    Logger.info("Notification sent to #{user.name}")
  end
end
