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
	lines = File.read!("test/year_2022/day_10_test_input.txt")
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
end
