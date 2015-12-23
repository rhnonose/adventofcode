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
    moves |>
    String.codepoints |>
    Enum.reduce([{0,0}], 
      fn (movement, trail) ->
        trail ++ [calculate_coordinate(movement, List.last(trail))]
      end)
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
