defmodule DayOne do

  def walk(state = %{facing: :north, x: x, y: y}, :right, distance), do: %{state | facing: :east, x: x + distance}
  def walk(state = %{facing: :east,  x: x, y: y}, :right, distance), do: %{state | facing: :south, y: y - distance}
  def walk(state = %{facing: :south, x: x, y: y}, :right, distance), do: %{state | facing: :west, x: x - distance}
  def walk(state = %{facing: :west,  x: x, y: y}, :right, distance), do: %{state | facing: :north, y: y + distance}
  def walk(state = %{facing: :north, x: x, y: y}, :left,  distance), do: %{state | facing: :west, x: x - distance}
  def walk(state = %{facing: :west,  x: x, y: y}, :left,  distance), do: %{state | facing: :south, y: y - distance}
  def walk(state = %{facing: :south, x: x, y: y}, :left,  distance), do: %{state | facing: :east, x: x + distance}
  def walk(state = %{facing: :east,  x: x, y: y}, :left,  distance), do: %{state | facing: :north, y: y + distance}

  def query_distance(%{x: x, y: y}), do: abs(x) + abs(y)

  def solve(file) do
    File.read!(file)
    |> String.split(", ")
    |> Enum.reduce(%{facing: :north, x: 0, y: 0}, &parse/2)
    |> query_distance
  end

  defp parse("R" <> distance, acc) do
    {int, ""} = Integer.parse(distance)
    walk(acc, :right, int)
  end

  defp parse("L" <> distance, acc) do
    {int, ""} = Integer.parse(distance)
    walk(acc, :left, int)
  end

end