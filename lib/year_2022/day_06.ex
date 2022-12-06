defmodule Year2022.Day06 do
  def part_1(str) do
    chars = String.graphemes(str)
    range = 0..(length(chars) - 1)

    Enum.reduce_while(range, 0, fn i, _acc ->
      if next_four_elements(chars, i) == 4, do: {:halt, i}, else: {:cont, 0}
    end) + 4
  end

  def next_four_elements(chars, index) do
    Enum.slice(chars, index, 4)
    |> Enum.uniq()
    |> Enum.count()
  end
end
