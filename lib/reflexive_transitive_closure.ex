defmodule ReflexiveTransitiveClosureSolver do

  def mapReflexiveClosure(input, position) do
    case Enum.fetch(input, position) do
      {:ok, tuple} ->
        {x, y} = tuple
        cond do
          !Enum.member?(input, {x, x}) -> mapReflexiveClosure(input ++ [{x, x}], position)
          !Enum.member?(input, {y, y}) -> mapReflexiveClosure(input ++ [{y, y}], position + 1)
          true -> mapReflexiveClosure(input, position + 1)
        end
      :error -> input
    end
  end

  def mapTransitiveClosure(fixed_position, input, varying_position) do
    case Enum.fetch(input, fixed_position) do
      {:ok, tuple} ->
        case Enum.fetch(input, varying_position) do
          {:ok, analised} ->
            {source, destination} = tuple
            {analised_source, analised_destination} = analised
            new_tuple =  {source, analised_destination}
            case ((destination == analised_source) && (!Enum.member?(input, new_tuple))) do
              true -> mapTransitiveClosure(fixed_position, input ++ [new_tuple], varying_position + 1)
              _ -> mapTransitiveClosure(fixed_position, input, varying_position + 1)
            end
          :error -> mapTransitiveClosure(fixed_position + 1, input, 0)
        end
        :error -> input
    end
  end

  def reflexive_transitive_closure(input) do
    reflexive_closure = mapReflexiveClosure(input, 0)
    mapTransitiveClosure(0, reflexive_closure, 1) |> Enum.sort()
  end
end
