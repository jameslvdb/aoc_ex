defmodule Year2022.Day06Test do
  use ExUnit.Case
  alias Year2022.Day06

  test "finds the start of packet marker" do
	str1 = "bvwbjplbgvbhsrlpgdmjqwftvncz"
	str2 = "nppdvjthqldpwncqszvftbrmjlhg"
	str3 = "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg"
	str4 = "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw"

    assert Day06.part_1(str1) == 5
    assert Day06.part_1(str2) == 6
    assert Day06.part_1(str3) == 10
    assert Day06.part_1(str4) == 11
  end

  test "full part 1" do
    File.read!("inputs/year_2022/day_06.txt")
    |> Day06.part_1()
    |> dbg()
  end

  test "finds the start of message marker" do

  end
end
