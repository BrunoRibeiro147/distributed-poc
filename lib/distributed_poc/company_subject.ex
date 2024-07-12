defmodule DistributedPoc.CompanySubject do
  use Ecto.Schema

  import Ecto.Changeset

  @required_fields ~w(name balance)a

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "company_subjects" do
    field(:name, :string)
    field(:balance, :decimal, default: Decimal.new("0.00"))
  end

  def changeset(schema \\ %__MODULE__{}, params) do
    schema
    |> cast(params, @required_fields)
    |> validate_required(@required_fields)
  end
end
