defmodule TacnoAb.Repo do
  use Ecto.Repo, otp_app: :tacno_ab, adapter: Mongo.Ecto
end
