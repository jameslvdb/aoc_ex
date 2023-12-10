defmodule Year2022.Day01 do
  @moduledoc """
  https://adventofcode.com/2022/day/1
  """

  # Input is the number of calories that each elf is carrying.
  #
  # Goal: Find the Elf carrying the most Calories.
  # Answer: How many total Calories is that Elf carrying?

  def part_1(input) do
    calories_per_elf(input)
    |> Enum.max()
  end

  def part_2(input) do
    calories_per_elf(input)
    |> Enum.sort()
    |> Enum.reverse()
    |> Enum.take(3)
    |> Enum.sum()
  end

  defp calories_per_elf(input) do
    input
    |> String.split("\n\n", trim: true)
    |> Enum.map(&split_and_convert/1)
    |> Enum.map(&Enum.sum/1)
  end

  defp split_and_convert(str) do
    String.split(str, "\n", trim: true)
    |> Enum.map(&String.to_integer/1)
  end
end
