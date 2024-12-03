defmodule Year2024.Day03 do
  def solve() do
    input = InputHelper.input_for(2024, 3)
    IO.puts("Part 1: #{part_1(input)}")
    IO.puts("Part 2: #{part_2(input)}")
  end

  def part_1(input) do
    Regex.scan(~r/mul\((\d+),(\d+)\)/, input)
    |> Enum.map(fn [_match, x, y] ->
      String.to_integer(x) * String.to_integer(y)
    end)
    |> Enum.sum()
  end

  def part_2(input) do
    do_exp = ~r/do\(\)/

    Regex.split(do_exp, input)
    |> Enum.map(&enabled_mul_instructions/1)
    |> Enum.map(&part_1/1)
    |> Enum.sum()
  end

  def enabled_mul_instructions(s) do
    dont_exp = ~r/don't\(\)/

    Regex.split(dont_exp, s)
    |> hd()
  end
end
