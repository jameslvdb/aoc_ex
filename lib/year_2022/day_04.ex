defmodule Year2022.Day04 do
  def full_part_1(input) do
    split_lines(input)
    |> part_1()
  end

  def full_part_2(input) do
    split_lines(input)
    |> part_2()
  end

  def part_1(lines) do
    Enum.map(lines, fn x -> String.split(x, ",") end)
    |> Enum.map(fn assignment ->
      Enum.map(assignment, fn x -> create_ranges(x) end)
    end)
    |> Enum.map(&check_ranges/1)
    |> Enum.count(fn x -> x == true end)
  end

  def part_2(lines) do
    Enum.map(lines, fn x -> String.split(x, ",") end)
    |> Enum.map(fn assignment ->
      Enum.map(assignment, fn x -> create_ranges(x) end)
    end)
    |> Enum.map(&check_range_overlap/1)
    |> Enum.count(fn x -> x == true end)
  end

  def check_ranges([range_a, range_b]) do
    cond do
      range_a.first in range_b && range_a.last in range_b ->
        true

      range_b.first in range_a && range_b.last in range_a ->
        true

      true ->
        false
    end
  end

  def check_range_overlap([range_a, range_b]) do
    !Range.disjoint?(range_a, range_b)
  end

  def create_ranges(assignment) do
    [left, right] =
      String.split(assignment, "-")
      |> Enum.map(&String.to_integer/1)

    Range.new(left, right)
  end

  defp split_lines(input) do
    String.split(input, "\n", trim: true)
  end
end
