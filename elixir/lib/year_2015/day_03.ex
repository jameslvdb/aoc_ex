defmodule Year2015.Day03 do
  def part_1() do
    houses = %{
      {0, 0} => 1
    }

    position = {0, 0}

    InputHelper.input_for(2015, 3)
    |> parse_input()
    |> Enum.reduce(houses, fn move, houses -> process_move(move, houses, position) end)
  end

  defp parse_input(input) do
    String.graphemes(input)
  end

  def process_move("^", houses, {x, y}) do
    new_pos = {x, y + 1}

    Map.update(houses, new_pos, 1, fn x -> x + 1 end)
  end

  def process_move("v", houses, {x, y}) do
    new_pos = {x, y - 1}

    Map.update(houses, new_pos, 1, fn x -> x + 1 end)
  end

  def process_move(">", houses, {x, y}) do
    new_pos = {x + 1, y}

    Map.update(houses, new_pos, 1, fn x -> x + 1 end)
  end

  def process_move("<", houses, {x, y}) do
    new_pos = {x - 1, y}

    Map.update(houses, new_pos, 1, fn x -> x + 1 end)
  end
end
