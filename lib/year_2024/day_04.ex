defmodule Year2024.Day04 do
  def solve() do
    input = InputHelper.input_for(2024, 4)
    IO.puts("Part 1: #{part_1(input)}")
    IO.puts("Part 2: #{part_2(input)}")
  end

  def part_1(input) do
    coordinates_by_letter =
      input
      |> to_matrix()
      |> build_coordinates()

    locations_to_check = find_possible_locations(coordinates_by_letter)

    Enum.map(locations_to_check, fn x_location ->
      Enum.map(x_location, fn map ->
        Enum.map(map, fn {char, coordinate} ->
          Enum.member?(Map.get(coordinates_by_letter, char), coordinate)
        end)
        |> Enum.all?()
      end)
    end)
    |> List.flatten()
    |> Enum.count(&(&1 == true))
  end

  def part_2(_input) do
    nil
  end

  def to_matrix(raw_input) do
    raw_input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.graphemes/1)
  end

  def build_coordinates(matrix) do
    matrix
    |> Enum.with_index()
    |> Enum.flat_map(fn {row, row_index} ->
      row
      |> Enum.with_index()
      |> Enum.map(fn {cell, column_index} ->
        {cell, {row_index, column_index}}
      end)
    end)
    |> Enum.group_by(fn {char, _} -> char end)
    |> Enum.map(fn {char, coords} ->
      {char, Enum.map(coords, fn {_, coord} -> coord end)}
    end)
    |> Enum.into(%{}, fn {char, coords} -> {String.to_atom(char), coords} end)
  end

  def find_possible_locations(coordinates) do
    %{X: x_coords, M: _m_coords, A: _a_coords, S: _s_coords} = coordinates

    _example_grid = [
      [1, 2, 3, 4, 5],
      [2, 3, 1, 5, 4],
      [3, 1, 2, 4, 5],
      [4, 5, 3, 1, 2],
      [5, 4, 2, 3, 1]
    ]

    Enum.map(x_coords, fn {row, col} ->
      functions = [
        &left_to_right/1,
        &right_to_left/1,
        &top_to_bottom/1,
        &bottom_to_top/1,
        &up_and_right/1,
        &up_and_left/1,
        &down_and_right/1,
        &down_and_left/1
      ]

      Enum.map(functions, fn f -> f.({row, col}) end)
    end)
  end

  defp left_to_right({row, col}) do
    %{
      M: {row, col + 1},
      A: {row, col + 2},
      S: {row, col + 3}
    }
  end

  defp right_to_left({row, col}) do
    %{
      M: {row, col - 1},
      A: {row, col - 2},
      S: {row, col - 3}
    }
  end

  defp top_to_bottom({row, col}) do
    %{
      M: {row + 1, col},
      A: {row + 2, col},
      S: {row + 3, col}
    }
  end

  defp bottom_to_top({row, col}) do
    %{
      M: {row - 1, col},
      A: {row - 2, col},
      S: {row - 3, col}
    }
  end

  defp up_and_right({row, col}) do
    %{
      M: {row - 1, col + 1},
      A: {row - 2, col + 2},
      S: {row - 3, col + 3}
    }
  end

  defp up_and_left({row, col}) do
    %{
      M: {row - 1, col - 1},
      A: {row - 2, col - 2},
      S: {row - 3, col - 3}
    }
  end

  defp down_and_right({row, col}) do
    %{
      M: {row + 1, col + 1},
      A: {row + 2, col + 2},
      S: {row + 3, col + 3}
    }
  end

  defp down_and_left({row, col}) do
    %{
      M: {row + 1, col - 1},
      A: {row + 2, col - 2},
      S: {row + 3, col - 3}
    }
  end
end
