defmodule DayOneTest do
  use ExUnit.Case

  test "the basic" do
    %{facing: :north, x: 0, y: 0}
    |> DayOne.walk(:right, 2)
    |> assert_result(%{facing: :east, x: 2, y: 0})
    |> DayOne.walk(:left, 3)
    |> assert_result(%{facing: :north, x: 2, y: 3})
    |> DayOne.walk(:right, 2)
    |> assert_result(%{facing: :east, x: 4, y: 3})
    |> DayOne.walk(:right, 2)
    |> assert_result(%{facing: :south, x: 4, y: 1})
    |> DayOne.walk(:right, 2)
    |> assert_result(%{facing: :west, x: 2, y: 1})
    |> DayOne.walk(:right, 5)
    |> assert_result(%{facing: :north, x: 2, y: 6})
    |> DayOne.query_distance
    |> assert_result(8)
  end

  test "parse input" do
    assert DayOne.solve("test/day_one_input.txt") == 332
  end

  defp assert_result(a, b) do
    assert a == b
    a
  end

end