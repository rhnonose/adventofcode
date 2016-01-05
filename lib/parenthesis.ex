defmodule Parenthesis do

  def start(_type, _args) do
    Parenthesis.Supervisor.start_link()
  end

  def read_from_file(path) do
    path |>
    File.open! |>
    IO.binread(:all)
  end

  def count_parenthesis(path) do
    path |>
    read_from_file |>
    String.codepoints |>
    find_parenthesis(0)
  end

  def find_enter_basement(path) do
    path |>
    read_from_file |>
    String.codepoints |>
    find_position(0, 0)
  end

  def find_position(["(" | tail], acc, pos) 
  when acc >= 0
  do
    find_position(tail, acc+1, pos+1)
  end

  def find_position([")" | tail], acc, pos)
  when acc >= 0
  do
    find_position(tail, acc-1, pos+1)
  end

  def find_position(_, _, pos) do
    pos
  end

  def find_parenthesis(["(" | tail], acc) do
    find_parenthesis(tail, acc+1)
  end

  def find_parenthesis([")" | tail], acc) do
    find_parenthesis(tail, acc-1)
  end

  def find_parenthesis(["\n" |_], acc) do
    acc
  end

end
