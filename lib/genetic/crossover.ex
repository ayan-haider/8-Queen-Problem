defmodule Genetic.Crossover do
  alias Genetic.Fitness

  def changeChromosome(instance) do
    x = -1
    child = whileChangeChromosome(x, instance)
    child
  end

  defp whileChangeChromosome(x, instance) when x == 0 do
    instance
  end
  defp whileChangeChromosome(x, instance) when x != 0 do
    x = 0
    tmp = instance
    temp = getHeuristic(tmp)
    index = getIndex(temp)
    maxFitness = Fitness.getFitness(tmp)
    {x, _, _} = Enum.reduce(1..8, {x, tmp, maxFitness}, fn y, {x, tmp, maxFitness} ->
      tmp = List.replace_at(tmp, index, y)
      {x, maxFitness} =
        if Fitness.getFitness(tmp) > maxFitness do
          maxFitness = Fitness.getFitness(tmp)
          {y, maxFitness}
        else
          {x, maxFitness}
        end
      {x, tmp, maxFitness}
    end)
    instance = if x == 0 do
      Enum.reduce(0..(length(instance)-2), instance, fn x, acc ->
        Enum.reduce((x+1)..(length(instance)-2), acc, fn y, acc1 ->
          if Enum.at(acc1, x) == Enum.at(acc1, y) do
            acc1 = List.replace_at(acc1, y, (:rand.uniform(7)+1))
          else
            acc1
          end
        end)
      end)
    else
      instance = List.replace_at(instance, index, x)
    end
    whileChangeChromosome(x, instance)
  end

  defp getHeuristic(instance) do
    heuristic =
      Enum.reduce(0..(length(instance)-2), [], fn x, acc ->
        y = x - 1
        acc = acc ++ [0]

        acc = Enum.reduce(y..0, acc, fn i, acc ->
          if (Enum.at(instance, x) == Enum.at(instance, i)) or (abs(Enum.at(instance, x) - Enum.at(instance, i)) == abs(x - i)) do
            acc = List.replace_at(acc, x, (Enum.at(acc, x) + 1))
            acc
          else
            acc
          end
        end)
        #IO.inspect {"previous acc", acc}
        y = x + 1

        Enum.reduce(y..(length(instance)-1), acc, fn i, acc ->
          if (Enum.at(instance, x) == Enum.at(instance, i)) or (abs(Enum.at(instance, x) - Enum.at(instance, i)) == abs(x - i)) do
            acc = List.replace_at(acc, x, (Enum.at(acc, x) + 1))
            acc
          else
            acc
          end
        end)
        acc
      end)
    #IO.inspect {"heuristic", heuristic}
    heuristic
  end

  defp getIndex(instance) do
    elem = 0
    result = instance
    |> Enum.with_index
    |> Enum.map(fn {e, i} -> [e, i] end)
    |> Enum.reduce(elem, fn x, acc ->
      if Enum.at(x, 0) == Enum.max(instance) do
        acc = Enum.at(x, 1)
      else
        acc
      end
    end)
    result
  end
end
