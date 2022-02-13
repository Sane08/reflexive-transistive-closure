defmodule ReflexiveTransitiveClosureSolver do

  def mapReflexiveClosure(input, position \\ 0) do
    case Enum.fetch(input, position) do
      {:ok, tuple} ->
        {x, y} = tuple
        cond do
          !Enum.member?(input, {x, x}) -> mapReflexiveClosure(input ++ [{x, x}], position)
          !Enum.member?(input, {y, y}) -> mapReflexiveClosure(input ++ [{y, y}], position + 1)
          true -> mapReflexiveClosure(input, position + 1)
        end
      :error ->
        input
    end
  end

  def mapTransitiveClosure(input, fixed_position \\ 0, varying_position \\ 1) do
    case Enum.fetch(input, fixed_position) do
      {:ok, tuple} ->
        case Enum.fetch(input, varying_position) do
          {:ok, analyzed} ->
            {source, destination} = tuple
            {analyzed_source, analyzed_destination} = analyzed

            new_tuple =  {source, analyzed_destination}

            case ((destination == analyzed_source) && (!Enum.member?(input, new_tuple))) do
              true ->
                mapTransitiveClosure(input ++ [new_tuple], fixed_position, varying_position + 1)
              _ ->
                mapTransitiveClosure(input, fixed_position, varying_position + 1)
            end
          :error ->
            mapTransitiveClosure(input, fixed_position + 1, 0)
        end
        :error ->
          input
    end
  end

  def reflexive_transitive_closure(input) do
    mapReflexiveClosure(input) |>
    mapTransitiveClosure() |>
    Enum.sort()
  end
end
