defmodule Surveys.Repo do
  use Ecto.Repo,
    otp_app: :surveys,
    adapter: Ecto.Adapters.Postgres
end
