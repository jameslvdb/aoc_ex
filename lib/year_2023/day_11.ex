defmodule Year2023.Day11 do
  def part_1(input) do
    parse_input(input)
  end

  defp parse_input(input) do
    lines = String.split("\n")

    Enum.map(lines, fn line ->
      String.graphemes(line)
      |> Enum.map(fn char -> if char == ".", do: "..", else: char end)
      |> Enum.join()
    end)
  end
end
