defmodule Year2024.Day01 do
  part_1_example_input = """
  3   4
  4   3
  2   5
  1   3
  3   9
  3   3
  """

  def setup(lines) do
    left =
      Enum.take_every(lines, 2)
      |> Enum.map(&String.to_integer/1)
      |> Enum.sort()

    right =
      Enum.take_every(Enum.drop(lines, 1), 2)
      |> Enum.map(&String.to_integer/1)
      |> Enum.sort()

    {left, right}
  end

  def part_1(input) do
    {left, right} =
      input
      |> String.split()
      |> setup()

    Enum.zip(left, right)
    |> Enum.map(fn {l, r} -> abs(l - r) end)
    |> Enum.sum()
  end

  def full_part_1() do
    InputHelper.input_for(2024, 1)
    |> part_1()
  end

  def part_2(input) do
    {left, right} =
      input
      |> String.split()
      |> setup()

    Enum.reduce(left, 0, fn x, acc ->
      acc + x * Enum.count(right, fn y -> x == y end)
    end)
  end

  def full_part_2() do
    InputHelper.input_for(2024, 1)
    |> part_2()
  end
end
