defmodule ReflexiveTransitiveClosureSolverTest do
  use ExUnit.Case
  doctest ReflexiveTransitiveClosureSolver

  def compare_solution_expected_output(solution, expected_output) do
    IO.inspect(solution)
    assert Enum.sort(solution) == Enum.sort(expected_output)
  end

  test "Teste 1" do
    assert compare_solution_expected_output(ReflexiveTransitiveClosureSolver.reflexive_transitive_closure(
      [{4, 1}, {7, 8}, {7, 11}, {8, 1}, {8, 4}, {11, 8}]),
      [
        {1, 1},
        {4, 1}, {4, 4},
        {7, 1}, {7, 4}, {7, 7}, {7, 8}, {7, 11},
        {8, 1}, {8, 4}, {8, 8},
        {11, 1}, {11, 4}, {11, 8}, {11, 11}
      ])
  end

  test "Teste 2" do
    assert compare_solution_expected_output(ReflexiveTransitiveClosureSolver.reflexive_transitive_closure(
      [{3, 8}, {3, 10}, {5, 11}, {7, 8}, {7, 11}, {8, 9}, {11, 9}, {11, 10}, {11, 2}]),
      [
        {2, 2},
        {3, 3}, {3, 8}, {3, 9}, {3, 10},
        {5, 2}, {5, 5}, {5, 9}, {5, 10}, {5, 11},
        {7, 2}, {7, 7}, {7, 8}, {7, 9}, {7, 10}, {7, 11},
        {8, 8}, {8, 9},
        {9, 9},
        {10, 10},
        {11, 2}, {11, 9}, {11, 10}, {11, 11}
      ])
  end

  test "Teste 3" do
    assert compare_solution_expected_output(ReflexiveTransitiveClosureSolver.reflexive_transitive_closure(
      [{1, 2}, {2, 3}, {2, 4}, {3, 1}, {4, 1}, {4, 3}]),
      [
        {1, 1}, {1, 2}, {1, 3}, {1, 4},
        {2, 1}, {2, 2}, {2, 3}, {2, 4},
        {3, 1}, {3, 2}, {3, 3}, {3, 4},
        {4, 1}, {4, 2}, {4, 3}, {4, 4}
      ])
  end

  test "Teste 4" do
    assert compare_solution_expected_output(ReflexiveTransitiveClosureSolver.reflexive_transitive_closure(
      [{1, 1}, {2, 2}, {3, 3}]),
      [
        {1, 1},
        {2, 2},
        {3, 3}
      ])
  end
end
