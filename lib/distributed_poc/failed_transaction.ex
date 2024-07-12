defmodule DistributedPoc.FailedTransaction do
  use Ecto.Schema

  import Ecto.Changeset

  alias DistributedPoc.CompanySubject

  @required_fields ~w(company_subject_id balance)a

  @primary_key {:id, :id, autogenerate: true}
  @foreign_key_type :binary_id
  schema "failed_transactions" do
    field(:balance, :decimal, default: Decimal.new("0.00"))

    belongs_to(:company_subject, CompanySubject)
  end

  def changeset(schema \\ %__MODULE__{}, params) do
    schema
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
  end
end
