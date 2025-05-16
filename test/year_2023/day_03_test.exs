defmodule Year2023.Day03Test do
  alias Year2023.Day03
  use ExUnit.Case

  describe "example cases" do
    test "it gets the correct result for part 1" do
      lines =
        InputHelper.example_input_for(2023, 3, 1)
        |> String.split("\n")

      assert Day03.part_1(lines) == 4361
    end

    test "it gets the correct result for part 2" do
      lines =
        InputHelper.example_input_for(2023, 3, 2)
        |> String.split("\n")

      assert Day03.part_2(lines) == 467_835
    end
  end

  test "it gets index and length of every number" do
    str = ".34..*.4"
    assert Day03.find_numbers(str) == [[{1, 2}], [{7, 1}]]
  end

  test "check_surrounding" do
    matrix_with_symbol = [
      "..*",
      ".9.",
      "..."
    ]

    assert Day03.check_surrounding([{1, 1}], 1, matrix_with_symbol) == 9
  end

  @tag :skip
  test "check_line" do
    # matrix_with_symbol = [
    #   "..*",
    #   ".9.",
    #   "..."
    # ]

    # indices_with_index =
    #   Enum.map(matrix_with_symbol, &Day03.find_numbers/1)
    #   |> Enum.with_index()

    # IO.inspect(Enum.map(indices_with_index, &Day03.check_line(&1, matrix_with_symbol)))
  end

  test "surrounding_chars" do
    matrix = [
      "..$....*....%.",
      "...56.........",
      "....#........."
    ]

    assert Day03.surrounding_chars({1, {3, 2}}, matrix) == ~w($ . . . . . . . # .)
  end

  test "above_row_chars" do
    matrix = [
      "..$....*....%.",
      "...56........."
    ]

    coords = {1, 3, 2}

    assert Day03.above_row_chars(coords, matrix) == ~w($ . . .)
  end

  test "below_row_chars" do
    matrix = [
      "..$....*....%.",
      "...56.........",
      "....#........."
    ]

    coords = {1, 3, 2}

    assert Day03.below_row_chars(coords, matrix) == ~w(. . # .)
  end

  test "current_row_chars" do
    matrix = [
      "..$....*....%.",
      "...56.........",
      "....#........."
    ]

    coords = {1, 3, 2}

    assert Day03.current_row_chars(coords, matrix) == ~w(. .)
  end

  test "numbers_above" do
    matrix = [
      "...56.....78..",
      "..$.*.......%.",
      "....#........."
    ]

    assert Day03.numbers_above(1, matrix, 4) == [56]
  end

  test "numbers_below" do
    matrix = [
      "...56.....78..",
      "..$.*.......%.",
      "....749........"
    ]

    assert Day03.numbers_below(1, matrix, 4) == [749]
  end

  test "numbers_surrounding" do
    matrix = [
      "...56.....78..",
      "..$.*99.....%.",
      "....749........"
    ]

    assert Day03.numbers_surrounding(1, matrix, 4) == [99]
  end

  test "find_surrounding_numbers" do
    matrix = [
      "...56.....78..",
      "..$.*99.....%.",
      "....749......."
    ]

    assert Day03.find_surrounding_numbers({1, 4}, matrix) == [56, 749, 99]
  end

  test "gear_ratio" do
    matrix = [
      "...56.....78..",
      "..$.*99.....%.",
      "....749......."
    ]

    assert Day03.gear_ratio({1, 4}, matrix) == 4_152_456
  end

  describe "testing if a gear is connected to a number" do
    test "is connected when the gear index is 1 less than the number start index" do
      line = ".....534..."

      gear_index = 4
      number_coords = [{5, 3}]

      assert Day03.is_connected_to_gear(number_coords, gear_index, line) == 534
    end

    test "is connected when the gear index is 1 more than the end of the number" do
      gear_index = 7
      number_coords = [{3, 4}]
      line = "...1235..."

      assert Day03.is_connected_to_gear(number_coords, gear_index, line) == 1235
    end

    test "is not connected when outside the bounds" do
      number_coords = [{3, 4}]
      line = "...356......"

      assert Day03.is_connected_to_gear(number_coords, 1, line) == nil
      assert Day03.is_connected_to_gear(number_coords, 8, line) == nil
    end
  end

  test "gear ratio of line with no gears" do
    matrix = []
    assert Day03.gear_ratio_per_line({[], 1}, matrix) == 0
  end

  test "gear ratio of line" do
    matrix = [
      "...56.....78..",
      "..$.*99.....%.",
      "....749......."
    ]

    assert Day03.gear_ratio_per_line({[[{4, 1}]], 1}, matrix) == [4_152_456]
  end
end
