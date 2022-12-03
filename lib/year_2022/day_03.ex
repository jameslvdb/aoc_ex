defmodule Year2022.Day03 do
  # For each line, we need to:
  # Split the line in half
  # Find the common element in each half
  # Find the value of the common

  def part_1(input) do
    input
    |> split_lines()
    |> Enum.map(&split_line_in_half/1)
    |> Enum.map(&find_common_element/1)
    |> Enum.map(&char_value/1)
    |> Enum.sum()
  end

  def part_2(input) do
    input
    |> Enum.chunk_every(3)
    |> Enum.map(fn rucksacks ->
      Enum.map(rucksacks, &String.graphemes/1)
      |> Enum.map(&MapSet.new/1)
    end)
    |> Enum.map(&find_badge/1)
    |> Enum.map(&char_value/1)
    |> Enum.sum()
  end

  def full_part_2(input) do
    input
    |> split_lines()
    |> part_2()
  end

  def split_line_in_half(line) do
    String.split_at(line, div(String.length(line), 2))
  end

  def find_common_element({left, right}) do
    String.myers_difference(left, right)
    |> Keyword.fetch!(:eq)
  end

  def find_badge([one, two, three]) do
    MapSet.intersection(one, two)
    |> MapSet.intersection(three)
    |> MapSet.to_list()
    |> hd()
  end

  def char_value(char) do
    value =
      String.to_charlist(char)
      |> hd()

    cond do
      value >= 97 ->
        value - 96

      value ->
        value - 38
    end
  end

  defp split_lines(input) do
    String.split(input, "\n", trim: true)
  end
 end
