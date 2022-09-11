defmodule Genetic.Queen do
  alias Genetic.Fitness
  alias Genetic.Crossover
  alias Genetic.Child

  def algo() do
    father = populate()
    mother = populate()
    IO.inspect {"father", father}
    IO.inspect {"mother", mother}
    fitnessFather = Fitness.getFitness(father)
    fitnessMother = Fitness.getFitness(mother)

    {father, mother} = whileAlgo(father, mother, fitnessFather, fitnessMother)

    if Fitness.getFitness(father) == 28 do
      father
    else
      mother
    end
  end

  defp populate() do
    Enum.reduce(0..7, [], fn _, acc -> acc ++ [:rand.uniform(7)] end)
  end

  defp whileAlgo(father, mother, fitnessFather, fitnessMother) when fitnessFather == 28 or fitnessMother == 28 do
    {father, mother}
  end
  defp whileAlgo(father, mother, fitnessFather, fitnessMother) when fitnessFather != 28 and fitnessMother != 28 do
    child1 = Child.buildKid(father, mother, 4)
    child2 = Child.buildKid(mother, father, 4)

    IO.inspect {"child1", child1}
    IO.inspect {"child2", child2}

    child1 = Crossover.changeChromosome(child1)
    child2 = Crossover.changeChromosome(child2)

    IO.inspect {"New child1", child1}
    IO.inspect {"New child2", child2}

    fitnessFather = Fitness.getFitness(child1)
    fitnessMother = Fitness.getFitness(child2)

    whileAlgo(child1, child2, fitnessFather, fitnessMother)
  end
end
