defmodule Year2022.Day09Test do
  use ExUnit.Case
  alias Year2022.Day09

  test "part_1" do
    input = [
      "R 4",
      "U 4",
      "L 3",
      "D 1",
      "R 4",
      "D 1",
      "L 5",
      "R 2"
    ]

    Day09.part_1(input)
    |> dbg()
  end
end
