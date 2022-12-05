defmodule Year2022.Day05Test do
  alias Year2022.Day05
  use ExUnit.Case

  test "split by row" do
    assert Day05.split_by_row("            [C]         [N] [R]") == [
             "",
             "",
             "",
             "C",
             "",
             "",
             "N",
             "R",
             ""
           ]
  end

  test "do part 1" do
    Day05.full_part_1()
  end
end
