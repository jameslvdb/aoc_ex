defmodule Year2022.Day05 do
  def full_part_1() do
    File.read!("inputs/year_2022/day_05.txt")
    |> split_lines()
    |> part_1()
  end

  def part_1(lines) do
    # create data structure to represent state of crates
    stacks =
      take_crate_lines(lines)
      |> build_stacks()

    take_move_lines(lines)
    |> Enum.reject(fn x -> x == "" || x == nil end)
    |> Enum.map(&build_move/1)
    |> Enum.reduce(stacks, fn x, acc -> perform_move(x, acc) end)
    |> Enum.map(&hd/1)
    |> Enum.join()
  end

  def full_part_2() do
    File.read!("inputs/year_2022/day_05.txt")
    |> split_lines()
    |> part_2()
  end

  def part_2(lines) do
    # create data structure to represent state of crates
    stacks =
      take_crate_lines(lines)
      |> build_stacks()

    take_move_lines(lines)
    |> Enum.reject(fn x -> x == "" || x == nil end)
    |> Enum.map(&build_move/1)
    |> Enum.reduce(stacks, fn x, acc -> perform_cratemover_9001_move(x, acc) end)
    |> Enum.map(&hd/1)
    |> Enum.join()
  end

  @doc """
  Builds the initial representation of the stacks of crates.
  """
  def build_stacks(lines_of_crates) do
    rows = Enum.map(lines_of_crates, &split_by_row/1)

    Enum.to_list(0..8)
    |> Enum.map(fn i -> Enum.map(rows, fn x -> Enum.at(x, i) end) end)
    |> Enum.map(fn x -> Enum.reject(x, fn y -> y == "" end) end)
  end

  def perform_move(move, stacks) do
    [count, from, to] = Map.values(move)
    {crates_to_move, remaining_crates} = Enum.split(Enum.at(stacks, from), count)

    reversed_crates = Enum.reverse(crates_to_move)

    List.replace_at(stacks, to, reversed_crates ++ Enum.at(stacks, to))
    |> List.replace_at(from, remaining_crates)
  end

  def perform_cratemover_9001_move(move, stacks) do
    [count, from, to] = Map.values(move)
    {crates_to_move, remaining_crates} = Enum.split(Enum.at(stacks, from), count)

    List.replace_at(stacks, to, crates_to_move ++ Enum.at(stacks, to))
    |> List.replace_at(from, remaining_crates)
  end

  def build_move(line) do
    # IO.puts("Line: #{line}")

    [count, from, to] =
      Regex.scan(~r/\d+/, line)
      |> List.flatten()
      |> Enum.map(&String.to_integer/1)

    # adjusting index values by 1 for array accessing
    %{count: count, from: from - 1, to: to - 1}
  end

  def take_crate_lines(lines) do
    Enum.take(lines, 8)
  end

  def take_move_lines(lines) do
    {_, moves} = Enum.split(lines, 10)
    moves
  end

  @doc """
  Splits a row into an array of strings, one for each stack column.
  """
  def split_by_row(row) do
    String.pad_trailing(row, 35)
    |> String.graphemes()
    |> Enum.chunk_every(4)
    |> Enum.map(fn x -> Enum.join(x) end)
    |> Enum.map(fn x -> String.trim(x) end)
    |> Enum.map(fn x -> String.trim(x, "[") end)
    |> Enum.map(fn x -> String.trim(x, "]") end)
  end

  defp split_lines(input) do
    String.split(input, "\n", trim: false)
  end
end
