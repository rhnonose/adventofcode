defmodule AdventCoins do

  def start(_type, _args) do
    AdventCoins.Supervisor.start_link()
  end

  def encrypt(acc) do
    acc_str = Integer.to_string(acc)
    :crypto.hash_init(:md5) |>
    :crypto.hash_update("iwrupvqb") |>
    :crypto.hash_update(acc_str) |>
    :crypto.hash_final |>
    Base.encode16
  end

  def find_hash(acc) do
    acc |>
    encrypt |>
    find_hash(acc)
  end

  def find_hash("000000" <> _, acc) do
    acc
  end
  
  def find_hash(_, acc) do
    encrypt(acc+1) |>
    find_hash(acc+1)
  end

end
