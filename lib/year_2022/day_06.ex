defmodule Year2022.Day06 do
  def part_1(str) do
    find_packet(str, 4)
  end

  def part_2(str) do
    find_packet(str, 14)
  end

  def find_packet(str, num_uniq_chars) do
    chars = String.graphemes(str)
    range = 0..(length(chars) - 1)

    Enum.reduce_while(range, 0, fn i, _acc ->
      if next_elements(chars, i, num_uniq_chars) == num_uniq_chars,
        do: {:halt, i},
        else: {:cont, 0}
    end) + num_uniq_chars
  end

  def next_elements(chars, index, count) do
    Enum.slice(chars, index, count)
    |> Enum.uniq()
    |> Enum.count()
  end
end
