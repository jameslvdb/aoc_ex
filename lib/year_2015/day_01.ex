defmodule Year2015.Day01 do
  def part_1(input) do
    String.graphemes(input)
    |> Enum.reduce(0, fn x, acc -> acc + paren_value(x) end)
  end

  def paren_value(char) do
    case char do
      "(" ->
        1

      ")" ->
        -1
    end
  end

  def full_part_1() do
    InputHelper.input_for(2015, 1)
    |> part_1()
  end
end
