defmodule DistributedPoc.Test1 do
  def execute() do
    tasks = [
      %{id: "4dc688bc-dffb-47d8-b29b-5ee4c5606f6e", balance: Decimal.new("15")},
      %{id: "30f58d09-5876-4aed-9bbb-4c46c1b1f6a2", balance: Decimal.new("11")},
      %{id: "4dc688bc-dffb-47d8-b29b-5ee4c5606f6e", balance: Decimal.new("16")},
      %{id: "4dc688bc-dffb-47d8-b29b-5ee4c5606f6e", balance: Decimal.new("24.50")},
      %{id: "30f58d09-5876-4aed-9bbb-4c46c1b1f6a2", balance: Decimal.new("31")},
      %{id: "30f58d09-5876-4aed-9bbb-4c46c1b1f6a2", balance: Decimal.new("18.75")}
    ]

    Task.async_stream(tasks, fn task ->
      DistributedPoc.Orchestrator.execute(task)
    end)
    |> Enum.to_list()
  end
end
