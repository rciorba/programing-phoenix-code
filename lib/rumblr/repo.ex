defmodule Rumblr.Repo do
  use Ecto.Repo,
    otp_app: :rumblr,
    adapter: Ecto.Adapters.Postgres
end
