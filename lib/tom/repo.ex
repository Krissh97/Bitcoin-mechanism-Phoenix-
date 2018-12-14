defmodule Tom.Repo do
  use Ecto.Repo,
    otp_app: :tom,
    adapter: Ecto.Adapters.Postgres
end
