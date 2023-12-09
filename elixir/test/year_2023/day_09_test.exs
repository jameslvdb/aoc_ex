defmodule Year2023.Day09Test do
  alias Year2023.Day09
  use ExUnit.Case

  test "part 1 example" do
    input = """
    0 3 6 9 12 15
    1 3 6 10 15 21
    10 13 16 21 30 45
    """

    assert Day09.part_1(input) == 114
  end

  test "part 2 example" do
    input = """
    0 3 6 9 12 15
    1 3 6 10 15 21
    10 13 16 21 30 45
    """

    assert Day09.part_2(input) == 2
  end

  test "differences" do
    assert Day09.differences([0, 3, 6, 9, 12, 15]) == [3, 3, 3, 3, 3]
    assert Day09.differences([1, 3, 6, 10, 15, 21]) == [2, 3, 4, 5, 6]
    assert Day09.differences([10, 13, 16, 21, 30, 45]) == [3, 3, 5, 9, 15]
  end

  test "build history" do
    assert Day09.build_history([0, 3, 6, 9, 12, 15]) == [[0, 3, 6, 9, 12, 15], [3, 3, 3, 3, 3]]

    assert Day09.build_history([1, 3, 6, 10, 15, 21]) == [
             [1, 3, 6, 10, 15, 21],
             [2, 3, 4, 5, 6],
             [1, 1, 1, 1]
           ]

    assert Day09.build_history([10, 13, 16, 21, 30, 45]) == [
             [10, 13, 16, 21, 30, 45],
             [3, 3, 5, 9, 15],
             [0, 2, 4, 6],
             [2, 2, 2]
             # [0, 0, 0]
           ]
  end

  test "find next value" do
    assert Day09.find_next_value([3, 3, 3, 3, 3], [0, 3, 6, 9, 12, 15]) == [
             0,
             3,
             6,
             9,
             12,
             15,
             18
           ]

    # assert Day09.find_next_value([1, 3, 6, 10, 15, 21]) == 28
    # assert Day09.find_next_value([10, 13, 16, 21, 30, 45]) == 60
  end

  test "find next from history" do
    # assert Day09.find_next_value([
    #          [0, 3, 6, 9, 12, 15],
    #          [1, 3, 6, 10, 15, 21],
    #          [10, 13, 16, 21, 30, 45]

    history = Day09.build_history([0, 3, 6, 9, 12, 15])
    assert Day09.find_next_value(history) == 18

    history = Day09.build_history([1, 3, 6, 10, 15, 21])
    assert Day09.find_next_value(history) == 28

    history = Day09.build_history([10, 13, 16, 21, 30, 45])
    assert Day09.find_next_value(history) == 68
  end
end
