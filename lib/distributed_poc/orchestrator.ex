defmodule DistributedPoc.Orchestrator do
  alias DistributedPoc.BalanceProcess

  def execute(transaction) do
    upsert_balance_process(:global.whereis_name(transaction.id), transaction)
  end

  defp upsert_balance_process(:undefined, transaction) do
    case BalanceProcess.start_process(transaction.id) do
      {:ok, pid} -> BalanceProcess.add_message_to_process(pid, transaction)
      {:error, {:already_started, pid}} -> BalanceProcess.add_message_to_process(pid, transaction)
    end
  end

  defp upsert_balance_process(pid, transaction),
    do: BalanceProcess.add_message_to_process(pid, transaction)
end
