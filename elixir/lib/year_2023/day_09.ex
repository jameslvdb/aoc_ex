defmodule Year2023.Day09 do
  def full_part_1() do
    InputHelper.input_for(2023, 9)
    |> part_1()
  end

  def part_1(input) do
    parse_input(input)
    |> Enum.map(&build_history/1)
    |> Enum.map(&find_next_value/1)
    |> Enum.reject(fn x -> x == nil end)
    |> Enum.sum()
  end

  def full_part_2() do
    InputHelper.input_for(2023, 9)
    |> part_2()
  end

  def part_2(input) do
    parse_input(input)
    |> Enum.map(&build_history/1)
    |> Enum.map(&find_next_value_left/1)
    |> Enum.reject(fn x -> x == nil end)
    |> Enum.sum()
  end

  defp parse_input(input) do
    String.split(input, "\n")
    |> Enum.map(&String.split/1)
    |> Enum.map(fn line -> Enum.map(line, &String.to_integer/1) end)
  end

  def find_next_value(lists) do
    lists = Enum.reverse(lists)

    [lowest | rest] = lists

    Enum.reduce(rest, lowest, fn list, acc ->
      find_next_value(acc, list)
    end)
    |> List.last()
  end

  def find_next_value_left(lists) do
    lists = Enum.reverse(lists)

    [lowest | rest] = lists

    Enum.reduce(rest, lowest, fn list, acc ->
      find_next_value_left(acc, list)
    end)
    |> List.first()
  end

  def find_next_value(below, above) do
    next_value = List.last(below) + List.last(above)
    above ++ [next_value]
  end

  def find_next_value_left(below, above) do
    next_value = List.first(above) - List.first(below)
    [next_value] ++ above
  end

  def differences(values) do
    values
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.map(fn [a, b] -> b - a end)
  end

  def build_history(line) do
    build_history([line], differences(line))
  end

  def build_history(lists, diffs) do
    all_zeroes? = Enum.all?(diffs, fn x -> x == 0 end)

    if all_zeroes? do
      lists
    else
      build_history(lists ++ [diffs], differences(diffs))
    end
  end
end
