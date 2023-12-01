defmodule Year2022.Day08Test do
  use ExUnit.Case
  alias Year2022.Day08

  test "it validates visibility along a row" do
    assert Day08.visible?([3, 0, 3, 7, 3], 0) == true
    assert Day08.visible?([3, 0, 3, 7, 3], 1) == false
    assert Day08.visible?([3, 0, 3, 7, 3], 2) == false
    assert Day08.visible?([3, 0, 3, 7, 3], 3) == true
    assert Day08.visible?([3, 0, 3, 7, 3], 4) == true

    assert Day08.visible?([2, 5, 5, 1, 2], 0) == true
    assert Day08.visible?([2, 5, 5, 1, 2], 1) == true
    assert Day08.visible?([2, 5, 5, 1, 2], 2) == true
    assert Day08.visible?([2, 5, 5, 1, 2], 3) == false
    assert Day08.visible?([2, 5, 5, 1, 2], 4) == true

    assert Day08.visible?([6, 5, 3, 3, 2], 0) == true
    assert Day08.visible?([6, 5, 3, 3, 2], 1) == true
    assert Day08.visible?([6, 5, 3, 3, 2], 2) == false
    assert Day08.visible?([6, 5, 3, 3, 2], 3) == true
    assert Day08.visible?([6, 5, 3, 3, 2], 4) == true

    assert Day08.visible?([3, 3, 5, 4, 9], 0) == true
    assert Day08.visible?([3, 3, 5, 4, 9], 1) == false
    assert Day08.visible?([3, 3, 5, 4, 9], 2) == true
    assert Day08.visible?([3, 3, 5, 4, 9], 3) == false
    assert Day08.visible?([3, 3, 5, 4, 9], 4) == true
  end

  test "part 1" do
    Day08.part_1(test_input) |> dbg()
    assert Day08.part_1(test_input) == 21
  end

  test "single line" do
    assert Day08.visible_trees_in_line([3, 0, 3, 7, 3], 0) == [{0, 0}, {0, 3}, {0, 4}]
    assert Day08.visible_trees_in_line([2, 5, 5, 1, 2], 0) == [{0, 0}, {0, 1}, {0, 2}, {0, 4}]
    assert Day08.visible_trees_in_line([6, 5, 4, 4, 2], 0) == [{0, 0}, {0, 1}, {0, 3}, {0, 4}]
    assert Day08.visible_trees_in_line([3, 3, 5, 4, 9], 0) == [{0, 0}, {0, 2}, {0, 4}]
    assert Day08.visible_trees_in_line([3, 5, 3, 9, 0], 0) == [{0, 0}, {0, 1}, {0, 3}, {0, 4}]
  end

  test "part 2" do
    assert Day08.part_2(test_input) == 8
  end

  test "scenic score - single tree" do
    assert Day08.scenic_score([1, 3, 2, 3, 0], 3) == [2, 1]
    assert Day08.scenic_score([1, 3, 2, 3, 0], 0) == [0, 1]
    assert Day08.scenic_score([1, 6, 2, 3, 4], 4) == [3, 0]
    assert Day08.scenic_score([1, 3, 2, 3, 0], 4) == [1, 0]
  end

  test "scenic score - single line" do
    assert Day08.scenic_scores_for_line([1, 3, 2, 3, 0]) == [
             [0, 1],
             [1, 2],
             [1, 1],
             [2, 1],
             [1, 0]
           ]
  end

  def test_input() do
    [
      [3, 0, 3, 7, 3],
      [2, 5, 5, 1, 2],
      [6, 5, 3, 3, 2],
      [3, 3, 5, 4, 9],
      [3, 5, 3, 9, 0]
    ]
  end

  def transposed_input() do
    [
      # {0, 0} => {0, 0}, {0, 1} => {1, 0}, {0, 2}, {2, 0}
      [3, 2, 6, 3, 3],
      [0, 5, 5, 3, 5],
      [3, 5, 3, 5, 3],
      [7, 1, 3, 4, 9],
      [3, 2, 2, 9, 0]
    ]
  end
end
