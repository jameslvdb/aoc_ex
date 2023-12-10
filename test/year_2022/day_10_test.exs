defmodule Year2022.Day10Test do
  alias Year2022.Day10
  use ExUnit.Case

  test "small test case" do
    lines = [
      "noop",
      "addx 3",
      "addx -5"
    ]

    assert Day10.register_values(lines) == [1, 1, 1, 4, 4, -1]
  end

  test "big test case" do
    lines =
      File.read!("test/year_2022/day_10_test_input.txt")
      |> String.trim()
      |> String.split("\n")

    assert Day10.part_1(lines) == 13140
  end

  describe "processing lines" do
    test "process a noop" do
      assert Day10.process_line([3, 1, 13], "noop") == [3, 3, 1, 13]
    end

    test "process an addx command" do
      assert Day10.process_line([5, 2, -3], "addx 4") == [9, 5, 5, 2, -3]
    end
  end

  test "part 2 test case" do
    lines =
      File.read!("test/year_2022/day_10_test_input.txt")
      |> String.trim()
      |> String.split("\n")

    Day10.part_2(lines)
    # |> dbg()
  end

  describe "draw pixel" do
    test "same number" do
      assert Day10.draw?(10, 10) == true
    end

    test "valid number, but not the same" do
      assert Day10.draw?(10, 9) == true
      assert Day10.draw?(0, 1) == true
    end

    test "different numbers" do
      assert Day10.draw?(1, 15) == false
    end
  end
end
