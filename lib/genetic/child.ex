defmodule Genetic.Child do
  def buildKid(parent1, parent2, crossover) do

    child = Enum.reduce(0..(crossover-1), [], fn _, y -> y ++ [Enum.at(parent1, :rand.uniform(7))] end)
    child = Enum.reduce(crossover..7, child, fn _, y -> y ++ [Enum.at(parent2, :rand.uniform(7))] end)
    #IO.inspect child
    child
  end
end
