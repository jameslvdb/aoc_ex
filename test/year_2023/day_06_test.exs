defmodule Year2023.Day06Test do
  alias Year2023.Day06
  use ExUnit.Case

  test "part 1 example" do
    input = """
    Time:      7  15   30
    Distance:  9  40  200
    """

    assert Day06.part_1(input) == 288
  end

  test "part 2 example" do
    input = """
    Time:      7  15   30
    Distance:  9  40  200
    """

    assert Day06.part_2(input) == 71503
  end

  test "test_game" do
    assert Day06.test_game(0, {7, 9}) == false
    assert Day06.test_game(1, {7, 9}) == false
    assert Day06.test_game(2, {7, 9}) == true
    assert Day06.test_game(3, {7, 9}) == true
    assert Day06.test_game(4, {7, 9}) == true
    assert Day06.test_game(5, {7, 9}) == true
    assert Day06.test_game(6, {7, 9}) == false
    assert Day06.test_game(7, {7, 9}) == false
  end

  test "lowest_winner" do
    assert Day06.lowest_winner({7, 9}) == 2
    assert Day06.lowest_winner({15, 40}) == 4
    assert Day06.lowest_winner({30, 200}) == 11
  end

  test "longest_winner" do
    assert Day06.longest_winner({7, 9}) == 5
    assert Day06.longest_winner({15, 40}) == 11
    assert Day06.longest_winner({30, 200}) == 19
  end

  test "number of winning times" do
    assert Day06.number_of_winning_times({7, 9}) == 4
    assert Day06.number_of_winning_times({15, 40}) == 8
    assert Day06.number_of_winning_times({30, 200}) == 9
  end
end
