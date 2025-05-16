defmodule Year2015.Day05 do
  def solve do
    IO.puts("Part 1: #{part_1()}")
    IO.puts("Part 2: #{part_2()}")
  end

  def part_1() do
    InputHelper.input_for(2015, 5)
    |> String.split("\n", trim: true)
    |> Enum.filter(&is_nice_p1?/1)
    |> Enum.count()
  end

  def part_2() do
    InputHelper.input_for(2015, 5)
    |> String.split("\n", trim: true)
    |> Enum.filter(&is_nice_p2?/1)
    |> Enum.count()
  end

  def is_nice_p1?(s) do
    Enum.all?([
      at_least_three_vowels?(s),
      repeated_letter?(s),
      has_no_banned_substrings?(s)
    ])
  end

  def at_least_three_vowels?(s) do
    Regex.scan(~r/[aeiou]/, s)
    |> Enum.count_until(3) == 3
  end

  def repeated_letter?(s) do
    Regex.match?(~r/(.)\1/, s)
  end

  def has_no_banned_substrings?(s) do
    banned_substrings = ~w(ab cd pq xy)
    !String.contains?(s, banned_substrings)
  end

  def repeated_pair?(s) do
    Regex.match?(~r/(..).*\1/, s)
  end

  def has_letter_sandwich?(s) do
    Regex.match?(~r/(.).\1/, s)
  end

  def is_nice_p2?(s) do
    has_letter_sandwich?(s) && repeated_pair?(s)
  end
end
