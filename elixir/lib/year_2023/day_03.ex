defmodule Year2023.Day03 do
  @symbol_regex ~r/[^\d\.]/
  @number_regex ~r/\d+/
  @gear_regex ~r/\*/

  def full_part_1() do
    InputHelper.input_for(2023, 3)
    |> String.split("\n")
    |> part_1()
  end

  def part_1(lines) do
    sum_of_numbers = 0
    number_indices = Enum.map(lines, &find_numbers/1)

    # Format is:
    # {[[{0, 3}], [{5, 3}]], 0}
    # {[], 1}
    # {[[{2, 2}], [{6, 3}]], 2}
    # {[], 3}
    # {[[{0, 3}]], 4}
    # {[[{7, 2}]], 5}
    # {[[{2, 3}]], 6}
    # {[[{6, 3}]], 7}
    # {[], 8}
    # {[[{1, 3}], [{5, 3}]], 9}
    # {indices, matrix_index}

    Enum.with_index(number_indices)
    |> Enum.map(fn x -> check_line(x, lines) end)
    |> List.flatten()
    |> Enum.sum()
  end

  def full_part_2() do
    InputHelper.input_for(2023, 3)
    |> String.split("\n")
    |> part_2()
  end

  def part_2(lines) do
    Enum.map(lines, &find_gears/1)
    |> Enum.with_index()
    |> Enum.map(&gear_ratio_per_line(&1, lines))
    |> List.flatten()
    |> Enum.sum()
  end

  def find_numbers(line) do
    Regex.scan(@number_regex, line, return: :index)
  end

  def check_line({indices, line_index}, matrix) do
    Enum.map(indices, fn pair -> check_surrounding(pair, line_index, matrix) end)
  end

  def check_surrounding([{index, length}], line_index, matrix) do
    line = Enum.at(matrix, line_index)
    number = String.slice(line, index, length)

    chars =
      surrounding_chars({line_index, {index, length}}, matrix)
      |> Enum.join()

    if String.match?(chars, @symbol_regex), do: String.to_integer(number), else: 0
  end

  def surrounding_chars({row_index, {index, length}}, matrix) do
    cond do
      row_index == 0 ->
        Enum.concat([
          current_row_chars({row_index, index, length}, matrix),
          below_row_chars({row_index, index, length}, matrix)
        ])

      row_index == Enum.count(matrix) - 1 ->
        Enum.concat([
          above_row_chars({row_index, index, length}, matrix),
          current_row_chars({row_index, index, length}, matrix)
        ])

      true ->
        Enum.concat([
          above_row_chars({row_index, index, length}, matrix),
          current_row_chars({row_index, index, length}, matrix),
          below_row_chars({row_index, index, length}, matrix)
        ])
    end
  end

  def above_row_chars({row_index, column_index, length}, matrix) do
    row = Enum.at(matrix, row_index - 1)

    substring = String.slice(row, column_index - 1, length + 2)
    String.graphemes(substring)
  end

  def below_row_chars({row_index, column_index, length}, matrix) do
    row = Enum.at(matrix, row_index + 1)
    # substring = String.slice(row, column_index - 1, length + 2)
    substring = find_chars(row, column_index - 1, length)
    String.graphemes(substring)
  end

  def current_row_chars({row_index, column_index, length}, matrix) do
    row = Enum.at(matrix, row_index)
    char_before = String.at(row, column_index - 1)
    char_after = String.at(row, column_index + length)
    [char_before, char_after]
  end

  defp find_chars(string, -1, length) do
    String.slice(string, 0, length + 1)
  end

  defp find_chars(string, index, length) do
    String.slice(string, index, length + 2)
  end

  def find_gears(line) do
    Regex.scan(@gear_regex, line, return: :index)
  end

  def gear_ratio_per_line({[], _row_index}, _matrix), do: 0

  def gear_ratio_per_line({coords, row_index}, matrix) do
    Enum.map(coords, fn [{col_index, _length}] ->
      gear_ratio({row_index, col_index}, matrix)
    end)
  end

  def gear_ratio({row_index, column_index}, matrix) do
    numbers = find_surrounding_numbers({row_index, column_index}, matrix)

    if length(numbers) <= 1,
      do: 0,
      else: Enum.product(numbers)
  end

  def find_surrounding_numbers({row_index, column_index}, matrix) do
    Enum.concat([
      numbers_above(row_index, matrix, column_index),
      numbers_below(row_index, matrix, column_index),
      numbers_surrounding(row_index, matrix, column_index)
    ])
  end

  def numbers_above(row_index, matrix, gear_index) do
    line = Enum.at(matrix, row_index - 1)

    Regex.scan(@number_regex, line, return: :index)
    |> Enum.map(fn pair -> is_connected_to_gear(pair, gear_index, line) end)
    |> Enum.filter(&(!is_nil(&1)))
  end

  def numbers_below(row_index, matrix, gear_index) do
    line = Enum.at(matrix, row_index + 1)

    Regex.scan(@number_regex, line, return: :index)
    |> Enum.map(fn pair -> is_connected_to_gear(pair, gear_index, line) end)
    |> Enum.filter(&(!is_nil(&1)))
  end

  def numbers_surrounding(row_index, matrix, gear_index) do
    line = Enum.at(matrix, row_index)

    Regex.scan(@number_regex, line, return: :index)
    |> Enum.map(fn pair -> is_connected_to_gear(pair, gear_index, line) end)
    |> Enum.filter(&(!is_nil(&1)))
  end

  def is_connected_to_gear([{index, length}], gear_index, line) do
    is_connected? = gear_index >= index - 1 && gear_index <= index + length

    if is_connected?, do: get_number(line, {index, length}), else: nil
  end

  defp get_number(line, {index, length}) do
    String.slice(line, index, length)
    |> String.to_integer()
  end
end
