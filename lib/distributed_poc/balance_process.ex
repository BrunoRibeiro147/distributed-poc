defmodule DistributedPoc.BalanceProcess do
  use GenServer

  alias DistributedPoc.CompanySubject
  alias DistributedPoc.FailedTransaction
  alias DistributedPoc.Repo

  @subject_limit Decimal.new("50.00")

  def start_process(name) do
    GenServer.start_link(__MODULE__, nil, name: {:global, name})
  end

  def add_message_to_process(pid, message) do
    GenServer.cast(pid, {:add_to_queue, message})
  end

  @impl true
  def init(_state) do
    queue = :queue.new()

    {:ok, %{queue: queue}}
  end

  @impl true
  def handle_cast({:add_to_queue, message}, state) do
    IO.inspect(message, label: "ADD TO QUEUE")

    case :queue.is_empty(state.queue) do
      true ->
        new_state = add_to_queue(message, state)
        send(self(), :consume_queue)
        {:noreply, new_state}

      false ->
        new_state = add_to_queue(message, state)
        {:noreply, new_state}
    end
  end

  @impl true
  def handle_info(:consume_queue, state) do
    case :queue.out(state.queue) do
      {{:value, message}, new_queue} ->
        process_message(message)
        send(self(), :consume_queue)
        {:noreply, Map.put(state, :queue, new_queue)}

      {:empty, _queue} ->
        new_queue = :queue.new()
        {:noreply, Map.put(state, :queue, new_queue), 15000}
    end
  end

  @impl true
  def handle_info(:timeout, state) do
    case :queue.is_empty(state.queue) do
      true ->
        {:stop, "finish queue processing", state}

      false ->
        send(self(), :consume_queue)
        {:noreply, state}
    end
  end

  defp add_to_queue(message, state) do
    new_queue = :queue.in(message, state.queue)

    Map.put(state, :queue, new_queue)
  end

  defp process_message(message) do
    company_subject = Repo.get(CompanySubject, message.id)

    new_balance = Decimal.add(company_subject.balance, message.balance)

    case Decimal.gt?(new_balance, @subject_limit) do
      true -> update_failed_transaction(message)
      false -> update_company_subject_balance(company_subject, new_balance)
    end
  end

  defp update_company_subject_balance(company_subject, new_balance) do
    company_subject
    |> CompanySubject.changeset(%{balance: new_balance})
    |> Repo.update()
  end

  defp update_failed_transaction(message) do
    %{balance: message.balance, company_subject_id: message.id}
    |> FailedTransaction.changeset()
    |> Repo.insert()
  end
end
