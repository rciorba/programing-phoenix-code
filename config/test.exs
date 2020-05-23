use Mix.Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.

config :rumblr,
  passwd: Rumblr.Accounts.Passwd.Mock

config :rumblr, Rumblr.Repo,
  username: "postgres",
  password: "supersecure",
  database: "rumblr_test#{System.get_env("MIX_TEST_PARTITION")}",
  hostname: "localhost",
  port: 5422,
  pool: Ecto.Adapters.SQL.Sandbox

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :rumblr, RumblrWeb.Endpoint,
  http: [port: 4002],
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# config :pbkdf2_elixir,
#   rounds: 1
