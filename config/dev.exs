import Config

# Configure your database
config :voice_commander, VoiceCommander.Repo,
  username: "postgres",
  password: "postgres",
  hostname: "127.0.0.1",
  port: 54322,
  database: "postgres",
  stacktrace: true,
  show_sensitive_data_on_connection_error: true,
  pool_size: 10

config :ex_aws,
  access_key_id: "625729a08b95bf1b7ff351a663f3a23c",
  secret_access_key: "850181e4652dd023b7a98c58ae0d2d34bd487ee0cc3254aed6eda37307425907",
  json_codec: Jason

config :ex_aws, :s3,
  scheme: "http://",
  host: "localhost",
  port: 54321,
  region: "local",
  endpoint: "http://127.0.0.1:54321/storage/v1/s3"

# For development, we disable any cache and enable
# debugging and code reloading.
#
# The watchers configuration can be used to run external
# watchers to your application. For example, we can use it
# to bundle .js and .css sources.
config :voice_commander, VoiceCommanderWeb.Endpoint,
  # Binding to loopback ipv4 address prevents access from other machines.
  # Change to `ip: {0, 0, 0, 0}` to allow access from other machines.
  http: [ip: {127, 0, 0, 1}, port: 4000],
  check_origin: false,
  code_reloader: true,
  debug_errors: true,
  secret_key_base: "p9uvl1EbzWF2pfYSLFxWBFPEA0nAg49xXQzWSqvK7mEWxt/SAiTvNSxIfwvWKFfy",
  watchers: [
    esbuild: {Esbuild, :install_and_run, [:voice_commander, ~w(--sourcemap=inline --watch)]},
    tailwind: {Tailwind, :install_and_run, [:voice_commander, ~w(--watch)]}
  ]

# ## SSL Support
#
# In order to use HTTPS in development, a self-signed
# certificate can be generated by running the following
# Mix task:
#
#     mix phx.gen.cert
#
# Run `mix help phx.gen.cert` for more information.
#
# The `http:` config above can be replaced with:
#
#     https: [
#       port: 4001,
#       cipher_suite: :strong,
#       keyfile: "priv/cert/selfsigned_key.pem",
#       certfile: "priv/cert/selfsigned.pem"
#     ],
#
# If desired, both `http:` and `https:` keys can be
# configured to run both http and https servers on
# different ports.

# Watch static and templates for browser reloading.
config :voice_commander, VoiceCommanderWeb.Endpoint,
  live_reload: [
    patterns: [
      ~r"priv/static/(?!uploads/).*(js|css|png|jpeg|jpg|gif|svg)$",
      ~r"priv/gettext/.*(po)$",
      ~r"lib/voice_commander_web/(controllers|live|components)/.*(ex|heex)$"
    ]
  ]

# Enable dev routes for dashboard and mailbox
config :voice_commander, dev_routes: true

# Do not include metadata nor timestamps in development logs
config :logger, :console, format: "[$level] $message\n"

# Set a higher stacktrace during development. Avoid configuring such
# in production as building large stacktraces may be expensive.
config :phoenix, :stacktrace_depth, 20

# Initialize plugs at runtime for faster development compilation
config :phoenix, :plug_init_mode, :runtime

config :phoenix_live_view,
  # Include HEEx debug annotations as HTML comments in rendered markup
  debug_heex_annotations: true,
  # Enable helpful, but potentially expensive runtime checks
  enable_expensive_runtime_checks: true

# Disable swoosh api client as it is only required for production adapters.
config :swoosh, :api_client, false
