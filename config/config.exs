# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :sample,
  ecto_repos: [Sample.Repo]

# Configures the endpoint
config :sample, SampleWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "XD9add1FbbK/3a1z1rY4j4jb8pWUJOOnHasXd6am04gYcpeL7GkHKj7vzq1lVShE",
  render_errors: [view: SampleWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Sample.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
