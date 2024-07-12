defmodule DistributedPoc.Repo.Migrations.AddFailedTransactionsTable do
  use Ecto.Migration

  def change do
   create table(:failed_transactions) do
     add :balance, :decimal
     add :company_subject_id, references(:company_subjects, type: :binary_id)
   end
  end
end
