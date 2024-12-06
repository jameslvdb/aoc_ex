defmodule Year2023.Day10 do
  @vert_pipe "|"
  @horizontal_pipe "-"
  @north_east_pipe "L"
  @north_west_pipe "J"
  @south_west_pipe "7"
  @south_east_pipe "F"
  @ground "."
  @animal "S"

  def part_1(input) do
    input
    |> parse_input()
  end

  def parse_input(input) do
    input
    |> String.split("\n", trim: true)
  end

  def build_map(lines) do
    enrich_input_with_coordinates(lines)
    |> List.flatten()
    |> Enum.reduce(%{}, fn {char, {x, y}}, acc ->
      Map.put(acc, {x, y}, char)
    end)
  end

  def connected_pipes(map, position) do
    _set = MapSet.new()

    pipe_at_position = Map.get(map, position)

    {row, col} = position

    connected_positions =
      case pipe_at_position do
        @animal ->
          [
            Map.get(map, {row + 1, col}),
            Map.get(map, {row - 1, col}),
            Map.get(map, {row, col + 1}),
            Map.get(map, {row, col - 1})
          ]

        @vert_pipe ->
          [
            Map.get(map, {row - 1, col}),
            Map.get(map, {row + 1, col})
          ]

        @horizontal_pipe ->
          [
            Map.get(map, {row, col - 1}),
            Map.get(map, {row, col + 1})
          ]

        @north_east_pipe ->
          [
            Map.get(map, {row - 1, col}),
            Map.get(map, {row, col + 1})
          ]

        @north_west_pipe ->
          [
            Map.get(map, {row - 1, col}),
            Map.get(map, {row, col - 1})
          ]

        @south_east_pipe ->
          [
            Map.get(map, {row + 1, col}),
            Map.get(map, {row, col + 1})
          ]

        @south_west_pipe ->
          [
            Map.get(map, {row + 1, col}),
            Map.get(map, {row, col - 1})
          ]
      end

    Enum.reject(connected_positions, fn x -> x == nil end)
  end

  def position_of_animal(map) do
    {pos, "S"} = Enum.find(map, fn {_k, v} -> v == @animal end)
    pos
  end

  def filter_ground(map) do
    Map.filter(map, fn {_k, v} -> v != @ground end)
  end

  def enrich_input_with_coordinates(input) do
    input
    |> Enum.with_index()
    |> Enum.map(fn {line, row_index} ->
      line
      |> String.graphemes()
      |> Enum.with_index()
      |> Enum.map(fn {char, column_index} ->
        {char, {row_index, column_index}}
      end)
    end)
  end

  def coordinates_of_animal(plot) do
    plot
    |> Enum.with_index()
    |> Enum.map(fn {line, line_index} ->
      line
      |> Enum.with_index()
      |> Enum.map(fn {char, char_index} ->
        if char == @animal do
          {line_index, char_index}
        end
      end)
    end)
    |> List.flatten()
    |> Enum.filter(&(&1 != nil))
  end
end
