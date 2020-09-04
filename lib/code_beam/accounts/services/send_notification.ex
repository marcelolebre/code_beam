defmodule CodeBeam.Accounts.Service.SendNotification do
  require Logger

  def call(name) do
    Logger.info("Notification sent to #{name}")
  end
end
