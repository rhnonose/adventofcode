defmodule DudeWhat do
  use Application

  # See http://elixir-lang.org/docs/stable/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec, warn: false

    children = [
      # Start the endpoint when the application starts
      supervisor(DudeWhat.Endpoint, []),
      # Start the Ecto repository
      supervisor(DudeWhat.Repo, []),
      # Here you could define other workers and supervisors as children
      # worker(DudeWhat.Worker, [arg1, arg2, arg3]),
    ]

    # See http://elixir-lang.org/docs/stable/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: DudeWhat.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    DudeWhat.Endpoint.config_change(changed, removed)
    :ok
  end


  def process_input(input_path, material) do
    File.open!(input_path) |>
    calculate_total(material)
  end

  def calculate_total(device, material) do
    IO.binread(device, :all) |>
    String.split("\n") |>
    calculate(material)
  end

  def split_lines(whole_file) do
    String.split(whole_file, "\n")
  end

  def calculate(dimensions, material) do
    dimensions |>
    Enum.filter(fn x -> String.length(x) > 0 end) |>
    Enum.map( 
      fn x -> String.split(x, "x") |> 
              Enum.map(fn y -> String.to_integer(y, 10) end) |>
              calculate_single(material)
      end) |>
    Enum.reduce(0, fn (x, acc) -> x + acc end)
  end

  def calculate_single([l, w, h], :paper) do
    Enum.min([l*w, w*h, h*l]) + 2*l*w + 2*w*h + 2*h*l
  end

  def calculate_single([l, w, h], :ribbon) do
    [first, second, _] = Enum.sort([l, w, h], fn x,y -> x<y end)
    2*first + 2*second + l*w*h
  end
end
