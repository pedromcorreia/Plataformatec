# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :to_do_list,
  ecto_repos: [ToDoList.Repo]

# Configures the endpoint
config :to_do_list, ToDoListWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "pml/ez2ojYcGhLtRMQCawTHx0q4v3sTMuEIz7K87SvFvYsuPulsWmKBIkBOxw8dF",
  render_errors: [view: ToDoListWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ToDoList.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:user_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

# %% Coherence Configuration %%   Don't remove this line
config :coherence,
  user_schema: ToDoList.Coherence.User,
  repo: ToDoList.Repo,
  module: ToDoList,
  web_module: ToDoListWeb,
  router: ToDoListWeb.Router,
  messages_backend: ToDoListWeb.Coherence.Messages,
  logged_out_url: "/",
  email_from_name: "Your Name",
  email_from_email: "yourname@example.com",
  opts: [:authenticatable, :recoverable, :lockable, :trackable, :unlockable_with_token, :invitable, :registerable]

config :coherence, ToDoListWeb.Coherence.Mailer,
  adapter: Swoosh.Adapters.Sendgrid,
  api_key: "your api key here"
# %% End Coherence Configuration %%
