use Mix.Config

# General application configuration
config :discuss, ecto_repos: [Discuss.Repo]

# Configures the endpoint
config :discuss, Discuss.Web.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "/G40kl2mseiEu0TGdrtNgMkjvviA7+nSJEHcePrgsV2dl7oZMLXASCWelaq8uYji",
  render_errors: [view: Discuss.Web.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Discuss.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

import_config "#{Mix.env()}.exs"

# Configurates the Ueberauth authentication app
config :ueberauth, Ueberauth,
  providers: [
    github: {Ueberauth.Strategy.Github, []}
  ]

import_config "config.secret.exs"
