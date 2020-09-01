defmodule CodeBeam.Repo do
  use Ecto.Repo,
    otp_app: :code_beam,
    adapter: Ecto.Adapters.Postgres
end
