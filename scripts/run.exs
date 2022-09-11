defmodule Run do
  alias Genetic.Queen

  solution = Queen.algo()
  IO.inspect solution
end
