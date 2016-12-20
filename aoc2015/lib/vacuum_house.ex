defmodule VacuumHouse  do
  use Application

  def start(_type, _args) do
    VacuumHouse.Supervisor.start_link() 
  end

  def process_input(path) do
    path |>
    File.open! |>
    IO.binread(:all) |>
    count_houses
  end

  def count_houses(moves) do
    moves |>
    register_trail |>
    Enum.uniq |>
    Enum.count
  end

  def register_trail(moves) do
    {santa, robot} =
    moves |>
    String.codepoints |>
    Enum.with_index |>
    Enum.partition(fn {_move, index} -> rem(index, 2) == 1 end)
    Enum.concat(build_trail(santa), build_trail(robot))
  end

  def build_trail(moves) do
    moves |>
    Enum.reduce([{0,0}],
      fn ({movement, _index}, trail) ->
        concat(trail, calculate_coordinate(movement, List.last(trail)))
      end)
  end

  def concat(trail, []) do
    trail
  end

  def concat(trail, mov) do
    trail ++ [mov]
  end

  def calculate_coordinate("v", {x,y}) do
    {x,y-1}
  end

  def calculate_coordinate("<", {x,y}) do
    {x-1,y}
  end

  def calculate_coordinate(">", {x,y}) do
    {x+1,y}
  end

  def calculate_coordinate("^", {x,y}) do
    {x,y+1}
  end

  def calculate_coordinate(_, _) do
    [] 
  end
end
