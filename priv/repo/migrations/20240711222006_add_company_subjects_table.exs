defmodule DistributedPoc.Repo.Migrations.AddCompanySubjectsTable do
  use Ecto.Migration

  def change do
   create table(:company_subjects, primary_key: false) do
     add :id, :binary_id, primary_key: true
     add :name, :string
     add :balance, :decimal
   end
  end
end
