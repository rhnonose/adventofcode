defmodule AdventCoins do

  def start(_type, _args) do
    AdventCoins.Supervisor.start_link()
  end

  def find_hash do
    :crypto.hash_init(:md5) |>
    :crypto.hash_update("iwrupvqb") |>
    find_5zero_hash(100000)
  end

  def find_5zero_hash(hash, input)
    when hash |> 
         :crypto.hash_update(input) |>
         :crypto.hash_final |>
         Base.encode16 |>
         String.starts_with?("00000")
  do
    input
  end

  def find_5zero_hash(hash, input) do
    hash |> find_5zero_hash(input+1)
  end

  def stop_condition(hash, input) do
    hash |>
    :crypto.hash_update(input) |>
    :crypto.hash_final |>
    Base.encode16 |>
    String.starts_with?("00000")
  end
  
end
