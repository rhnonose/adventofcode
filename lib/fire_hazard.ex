defmodule FireHazard do
  use Application

  def start(_type, _args) do
    FireHazard.Supervisor.start_link()
  end

  def process_input(path) do
    path |>   
    File.open! |>
    IO.binread(:all) |>
    String.split("\n") |>
    count_lights
  end

  def count_lights(commands) do
    commands |>
    Enum.map(parse_command) |>
    Enum.reduce([], process_command) |>
    Enum.count 
  end

  def format_command(command, mode) do
    [from,_,to] = String.split(command)
    [x1,y1] = String.split(from,",")
    [x2,y2] = String.split(to,",")
    {mode,
      {String.to_integer(x1),String.to_integer(y1)},
      {String.to_integer(x2),String.to_integer(y2)}
    }
  end

  def parse_command do
    fn command ->
      command |>
      parse_command
    end
  end

  def parse_command("turn on" <> rest) do
    format_command(rest, :on)
  end

  def parse_command("turn off" <> rest) do
    format_command(rest, :off)
  end

  def parse_command("toggle" <> rest) do
    format_command(rest, :toggle)
  end

  def parse_command(command) do
    :invalid_command
  end

  def process_command do
    fn arg, acc ->
      process_command(arg, acc)
    end
  end

  def process_command({:on,from,to},acc) do
    list = generate_columns(from, to)
    Enum.uniq(acc ++ list)
  end

  def process_command({:off,from,to},acc) do
    acc -- generate_columns(from,to)
  end

  def process_command({:toggle,from,to},acc) do
    to_toggle = generate_columns(from,to)
    (acc -- to_toggle) ++ (to_toggle -- acc)
  end

  def process_command(:invalid_command, _) do
    []
  end

  def generate_columns({from_x,from_y},{to_x,to_y})
    when from_y < to_y
  do
    generate_lines(from_x,from_y,to_x) ++
    generate_columns({from_x,from_y+1},{to_x,to_y})
  end

  def generate_columns({from_x,from_y},{to_x,_to_y}) do
    generate_lines(from_x,from_y,to_x)
  end

  def generate_lines(x,y,lim)
    when lim > x
  do
    [{x,y}] ++ generate_lines(x+1,y,lim)
  end

  def generate_lines(x,y,_lim) do
    [{x,y}]
  end
end
