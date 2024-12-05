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

  @doc """
  Needs to find the instances of `MAS` in an `X` shape in the grid, with A at the center.

  `MAS` can appear in four different directions:

  Southeast
  M . .
  . A .
  . . S

  Southwest
  . . M
  . A .
  S . .

  Northeast
  . . S
  . A .
  M . .

  Northwest
  S . .
  . A .
  . . M

  This means that there are 4 different combinations of `MAS` that can appear in the grid:

  - southeast and southwest
  M . M
  . A .
  S . S

  - northeast and northwest
  S . S
  . A .
  M . M

  - southeast and northeast
  M . S
  . A .
  M . S

  - southwest and northwest
  S . M
  . A .
  S . M
  """
  def part_2(input) do
    coordinates_by_letter =
      input
      |> to_matrix()
      |> build_coordinates()

    locations_to_check = build_cross_permutations(coordinates_by_letter[:A])

    Enum.map(locations_to_check, fn a_location ->
      Enum.map(a_location, fn %{M: [m_pair_1, m_pair_2], S: [s_pair_1, s_pair_2]} ->
        m_pair_1 in coordinates_by_letter[:M] &&
          m_pair_2 in coordinates_by_letter[:M] &&
          s_pair_1 in coordinates_by_letter[:S] &&
          s_pair_2 in coordinates_by_letter[:S]
      end)
    end)
    |> List.flatten()
    |> Enum.count(&(&1 == true))
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

  def build_cross_permutations(a_coords) do
    functions = [
      &southeast_and_southwest/1,
      &northeast_and_northwest/1,
      &southeast_and_northeast/1,
      &southwest_and_northwest/1
    ]

    Enum.map(a_coords, fn {row, col} ->
      Enum.map(functions, fn f -> f.({row, col}) end)
    end)
  end

  defp southeast_and_southwest({row, col}) do
    %{
      M: [
        {row - 1, col + 1},
        {row - 1, col - 1}
      ],
      S: [
        {row + 1, col + 1},
        {row + 1, col - 1}
      ]
    }
  end

  defp northeast_and_northwest({row, col}) do
    %{
      M: [
        {row + 1, col + 1},
        {row + 1, col - 1}
      ],
      S: [
        {row - 1, col + 1},
        {row - 1, col - 1}
      ]
    }
  end

  defp southeast_and_northeast({row, col}) do
    %{
      M: [
        {row - 1, col - 1},
        {row + 1, col - 1}
      ],
      S: [
        {row - 1, col + 1},
        {row + 1, col + 1}
      ]
    }
  end

  defp southwest_and_northwest({row, col}) do
    %{
      S: [
        {row - 1, col - 1},
        {row + 1, col - 1}
      ],
      M: [
        {row - 1, col + 1},
        {row + 1, col + 1}
      ]
    }
  end
end
