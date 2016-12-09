use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :tacno_ab, TacnoAb.Endpoint,
  http: [port: 4001],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Configure your database
config :tacno_ab, TacnoAb.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "tacno_ab_test",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
