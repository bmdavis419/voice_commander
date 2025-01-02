defmodule VoiceCommander.Repo do
  use Ecto.Repo,
    otp_app: :voice_commander,
    adapter: Ecto.Adapters.Postgres
end
