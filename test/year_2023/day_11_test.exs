defmodule Year2023.Day11Test do
  alias Year2023.Day11
  use ExUnit.Case

  test "part 1 example" do
    input = """
    ...#......
    .......#..
    #.........
    ..........
    ......#...
    .#........
    .........#
    ..........
    .......#..
    #...#.....
    """

    assert Day11.part_1(input) == nil
  end
end
