defmodule Genetic.Fitness do
  def getFitness(instance) do
    len = length(instance)
    clashes = Enum.reduce(0..(len-2), 0, fn x, acc ->
      Enum.reduce((x+1)..(len-1), acc, fn y, acc1 ->
        if Enum.at(instance, x) == Enum.at(instance, y) do
          acc1 + 1
        else
          acc1
        end
      end)
    end)
    clashes = Enum.reduce(0..(len-2), clashes, fn x, acc ->
      Enum.reduce((x+1)..(len-1), acc, fn y, acc1 ->
        if abs(Enum.at(instance, y) - Enum.at(instance, x)) == abs(y - x) do
          acc1 + 1
        else
          acc1
        end
      end)
    end)
    28 - clashes
end
end
