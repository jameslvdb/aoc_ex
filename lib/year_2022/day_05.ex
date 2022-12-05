defmodule Year2022.Day05 do
  def full_part_1() do
    File.read!("inputs/year_2022/day_05.txt")
    |> split_lines()
    |> part_1()
  end

  def part_1(lines) do
    # create data structure to represent state of crates
    take_crate_lines(lines)
    |> build_stacks()
    |> dbg()
  end

  def build_stacks(lines_of_crates) do
    rows = Enum.map(lines_of_crates, &split_by_row/1)

    Enum.to_list(0..8)
    |> Enum.map(fn i -> Enum.map(rows, fn x -> Enum.at(x, i) end) end)
    |> Enum.map(fn x -> Enum.reject(x, fn y -> y == "" end) end)
  end

  def take_crate_lines(lines) do
    Enum.take(lines, 8)
  end

  def split_by_row(row) do
    String.pad_trailing(row, 35)
    |> String.graphemes()
    |> Enum.chunk_every(4)
    |> Enum.map(fn x -> Enum.join(x) end)
    |> Enum.map(fn x -> String.trim(x) end)
    |> Enum.map(fn x -> String.trim(x, "[") end)
    |> Enum.map(fn x -> String.trim(x, "]") end)
  end

  def adjust_index(i) do
    i - 1
  end

  defp split_lines(input) do
    dbg(String.split(input, "\n", trim: false))
  end
end
