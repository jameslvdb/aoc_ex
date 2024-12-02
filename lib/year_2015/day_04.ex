defmodule Year2015.Day04 do
  @secret "yzbqklnj"

  def solve() do
    IO.puts("Part 1: #{part_1()}")
    IO.puts("Part 2: #{part_2()}")
  end

  def part_1() do
    find_lowest_number(5)
  end

  def part_2() do
    find_lowest_number(6)
  end

  def find_lowest_number(num_leading_zeros) do
    Enum.find(Stream.iterate(1, &(&1 + 1)), fn n ->
      create_key(n, @secret)
      |> get_hash()
      |> String.starts_with?(String.duplicate("0", num_leading_zeros))
    end)
  end

  def get_hash(s) do
    :erlang.md5(s)
    |> Base.encode16(case: :lower)
  end

  def create_key(num, secret_key) do
    secret_key <> Integer.to_string(num)
  end
end
