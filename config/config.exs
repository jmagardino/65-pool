# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :pool,
  ecto_repos: [Pool.Repo]

# Configures the endpoint
config :pool, PoolWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: PoolWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Pool.PubSub,
  live_view: [signing_salt: "YibC6b+d"]

# Configures OpenWeather API
config :pool, Pool.Weather,
  secret_key_openweather: "90e450a4996778f8bb2bd339c6f51ef7",
  endpoint_openweather: "http://api.openweathermap.org"

# Configures SportsDataIO API
config :pool, Pool.SportsData,
  secret_key_sportsdata: "a376fb697a594cd2a97c927f344c6f07"

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :pool, Pool.Mailer, adapter: Swoosh.Adapters.Local

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.0",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/* --external:/custom/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Configures Tailwind CSS
config :tailwind,
  version: "3.0.7",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
