defmodule LiveTalk.Repo do
  use Ecto.Repo,
    otp_app: :live_talk,
    adapter: Ecto.Adapters.Postgres
end
