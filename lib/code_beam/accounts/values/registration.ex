defmodule CodeBeam.Value.Registration do
  alias CodeBeam.Value

  def build(user, marvel_details) do
    user
    |> Value.init()
    |> Value.only([:name, :id])
    |> Value.add(marvel_details)
  end
end
