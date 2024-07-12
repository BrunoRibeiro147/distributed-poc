defmodule DistributedPoc.Repo do
  use Ecto.Repo,
    otp_app: :distributed_poc,
    adapter: Ecto.Adapters.Postgres
end
