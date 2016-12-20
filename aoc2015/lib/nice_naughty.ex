defmodule NiceNaughty do
  use Application

  def start(_type, _args) do
    NiceNaughty.Supervisor.start_link() 
  end

  def process_input(path, part) do
    path |>
    File.open! |>
    IO.binread(:all) |>
    String.split("\n") |>
    count_nice(part)
  end

  def is_nice?(:part1) do
    fn string ->
      has_three_vowels?(string) &&
      has_consecutive_letters?(string) &&
      !has_some_strings?(string)
    end
  end

  def is_nice?(:part2) do
    fn string ->
      has_not_overlapped_pairs?(string) &&
      has_repeated_letter_with_middleman?(string)
    end
  end

  def has_three_vowels?(string) do
    Regex.match?(~r/.*[aeiou].*[aeiou].*[aeiou].*/i, string)
  end

  def has_consecutive_letters?(string) do
    Regex.match?(~r/(.)\1/i, string)
  end

  def has_some_strings?(string) do
    Regex.match?(~r/.*(ab|cd|pq|xy).*/i, string)
  end

  def has_not_overlapped_pairs?(string) do
    Regex.match?(~r/(..).*\1/i, string)
  end

  def has_repeated_letter_with_middleman?(string) do
    Regex.match?(~r/(.).\1/i, string)
  end

  def count_nice(strings, part) do
    {nice, _naughty} = Enum.partition(strings, is_nice?(part))
    Enum.count(nice)
  end

end
