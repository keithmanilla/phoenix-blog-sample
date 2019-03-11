use Mix.Config

# In this file, we keep production configuration that
# you'll likely want to automate and keep away from
# your version control system.
#
# You should document the content of this
# file or create a script for recreating it, since it's
# kept out of version control and might be hard to recover
# or recreate for your teammates (or yourself later on).
config :sample, SampleWeb.Endpoint,
  secret_key_base: "I49+93PZZb9EDMepXAGVyGKb3mBByT9rlvBMKQnyVScYvhaLdk9+mdeFo1CRSbWd"

# Configure your database
config :sample, Sample.Repo,
  username: "postgres",
  password: "postgres",
  database: "sample_prod",
  pool_size: 15
