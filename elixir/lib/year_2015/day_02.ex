defmodule Year2015.Day02 do
  def part_1() do
    InputHelper.input_for(2015, 2)
    |> parse_input()
    |> Enum.map(fn x ->
      surface_area(x) + smallest_side(x)
    end)
    |> Enum.sum()
  end

  def part_2() do
    InputHelper.input_for(2015, 2)
    |> parse_input()
    |> Enum.map(fn x ->
      smallest_perimeter(x) + cubic_volume(x)
    end)
    |> Enum.sum()
  end

  defp parse_input(input) do
    input
    |> String.split("\n")
    |> Enum.map(&String.split(&1, "x"))
    |> Enum.map(&convert_to_ints/1)
  end

  defp surface_area([l, w, h]) do
    2 * l * w + 2 * l * h + 2 * w * h
  end

  defp smallest_side(dimensions) do
    [x, y, _] = Enum.sort(dimensions)

    x * y
  end

  defp smallest_perimeter(dimensions) do
    [x, y, _] = Enum.sort(dimensions)

    2 * x + 2 * y
  end

  defp cubic_volume(dimensions), do: Enum.product(dimensions)

  defp convert_to_ints(dimensions) do
    Enum.map(dimensions, &String.to_integer/1)
  end
end
