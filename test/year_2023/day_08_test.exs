defmodule Year2023.Day08Test do
  alias Year2023.Day08, as: Day
  use ExUnit.Case

  test "part 1 example" do
    input = """
    RL

    AAA = (BBB, CCC)
    BBB = (DDD, EEE)
    CCC = (ZZZ, GGG)
    DDD = (DDD, DDD)
    EEE = (EEE, EEE)
    GGG = (GGG, GGG)
    ZZZ = (ZZZ, ZZZ)
    """

    assert Day.part_1(input) == 2
  end

  test "part 1 example 2" do
    input = """
    LLR

    AAA = (BBB, BBB)
    BBB = (AAA, ZZZ)
    ZZZ = (ZZZ, ZZZ)
    """

    assert Day.part_1(input) == 6
  end

  test "part 2 example" do
    input = """
    LR

    11A = (11B, XXX)
    11B = (XXX, 11Z)
    11Z = (11B, XXX)
    22A = (22B, XXX)
    22B = (22C, 22C)
    22C = (22Z, 22Z)
    22Z = (22B, 22B)
    XXX = (XXX, XXX)
    """

    assert Day.part_2(input) == 6
  end

  test "least common multiple - base case" do
    assert Day.least_common_multiple(8, 12) == 24
  end

  test "least common multiple - list" do
    numbers = [8, 12, 20]

    assert Day.least_common_multiple(numbers) == 120
  end
end
