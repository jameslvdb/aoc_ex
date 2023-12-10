defmodule Year2015.Day01 do
  def part_1(input) do
    String.graphemes(input)
    |> Enum.reduce(0, fn x, acc -> acc + paren_value(x) end)
  end

  def part_2(input) do
    String.graphemes(input)
    |> Enum.reduce_while(%{floor: 0, index: 0}, fn paren, state ->
      if state.floor + paren_value(paren) == -1,
        do: {:halt, state.index + 1},
        else: {:cont, %{floor: state.floor + paren_value(paren), index: state.index + 1}}
    end)
  end

  def paren_value(char) do
    case char do
      "(" -> 1
      ")" -> -1
    end
  end

  def full_part_1() do
    InputHelper.input_for(2015, 1)
    |> part_1()
  end

  def full_part_2() do
    InputHelper.input_for(2015, 1)
    |> part_2()
  end
end
