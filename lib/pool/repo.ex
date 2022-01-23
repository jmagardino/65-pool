defmodule Pool.Repo do
  use Ecto.Repo,
    otp_app: :pool,
    adapter: Ecto.Adapters.Postgres
end
