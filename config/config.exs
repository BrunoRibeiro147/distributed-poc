import Config

config :distributed_poc, DistributedPoc.Repo,
  database: "distributed_poc_repo",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :distributed_poc, ecto_repos: [DistributedPoc.Repo]
