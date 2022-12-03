defmodule Year2022.Day03Test do
  alias Year2022.Day03
  use ExUnit.Case

  test "does something" do
    {:ok, input} = File.read("test/year_2022/day_03_test_input.txt")

    assert Day03.part_1(input) == 157
  end

  test "split line in half" do
    assert Day03.split_line_in_half("abc123") == {"abc", "123"}
  end

  test "finds the common element" do
    common =
      Day03.split_line_in_half("vJrwpWtwJgWrhcsFMMfFFhFp")
      |> Day03.find_common_element()

    assert common == "p"

    common =
      Day03.split_line_in_half("jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL")
      |> Day03.find_common_element()

    assert common == "L"

    common =
      Day03.split_line_in_half("PmmdzqPrVvPwwTWBwg")
      |> Day03.find_common_element()

    assert common == "P"

    common =
      Day03.split_line_in_half("wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn")
      |> Day03.find_common_element()

    assert common == "v"

    common =
      Day03.split_line_in_half("ttgJtRGJQctTZtZT")
      |> Day03.find_common_element()

    assert common == "t"
  end

  test "find char value" do
    assert Day03.char_value("a") == 1
    assert Day03.char_value("b") == 2
    assert Day03.char_value("A") == 27
    assert Day03.char_value("B") == 28
  end

  test "find the common element in part 2" do
    assert Day03.part_2([
      "vJrwpWtwJgWrhcsFMMfFFhFp",
      "jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL",
      "PmmdzqPrVvPwwTWBwg",
      "wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn",
      "ttgJtRGJQctTZtZT",
      "CrZsJsPPZsGzwwsLwLmpwMDw"
    ]) == 70
  end
end
