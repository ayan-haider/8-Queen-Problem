defmodule QueenTest do
  use ExUnit.Case
  doctest Queen

  test "greets the world" do
    assert Queen.hello() == :world
  end
end
