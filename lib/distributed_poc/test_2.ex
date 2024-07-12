defmodule DistributedPoc.Test2 do
  def execute() do
    tasks = [
      %{id: "1720da5c-feb2-4218-98d6-d9239b3d8ba2", balance: Decimal.new("5")},
      %{id: "30f58d09-5876-4aed-9bbb-4c46c1b1f6a2", balance: Decimal.new("10")},
      %{id: "1720da5c-feb2-4218-98d6-d9239b3d8ba2", balance: Decimal.new("10")},
      %{id: "1720da5c-feb2-4218-98d6-d9239b3d8ba2", balance: Decimal.new("10")},
      %{id: "30f58d09-5876-4aed-9bbb-4c46c1b1f6a2", balance: Decimal.new("7.50")},
      %{id: "1720da5c-feb2-4218-98d6-d9239b3d8ba2", balance: Decimal.new("15")},
      %{id: "30f58d09-5876-4aed-9bbb-4c46c1b1f6a2", balance: Decimal.new("22.50")},
      %{id: "1720da5c-feb2-4218-98d6-d9239b3d8ba2", balance: Decimal.new("20")},
      %{id: "1720da5c-feb2-4218-98d6-d9239b3d8ba2", balance: Decimal.new("10")}
    ]

    Task.async_stream(tasks, fn task ->
      DistributedPoc.Orchestrator.execute(task)
    end)
    |> Enum.to_list()
  end
end
