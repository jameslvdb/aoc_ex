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
    matrix_with_symbol = [
      "..*",
      ".9.",
      "..."
    ]

    indices_with_index =
      Enum.map(matrix_with_symbol, &Day03.find_numbers/1)
      |> Enum.with_index()

    IO.inspect(Enum.map(indices_with_index, &Day03.check_line(&1, matrix_with_symbol)))
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
end
