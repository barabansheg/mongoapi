use Mix.Config

config :mongoapi,
    db_url: System.get_env("DB_URL") || "mongodb://localhost:27017/urls"
