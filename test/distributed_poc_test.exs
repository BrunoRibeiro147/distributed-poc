defmodule DistributedPocTest do
  use ExUnit.Case
  doctest DistributedPoc

  test "greets the world" do
    assert DistributedPoc.hello() == :world
  end
end
