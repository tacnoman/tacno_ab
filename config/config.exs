# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :tacno_ab,
  ecto_repos: [TacnoAb.Repo]

# Configures the endpoint
config :tacno_ab, TacnoAb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "kXQGPj6D2lIXEQFVTjaPNWHuxzgujk8+UuDZzV6t/jgJzNglA3QiXpNOsTBIiU5h",
  render_errors: [view: TacnoAb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: TacnoAb.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
