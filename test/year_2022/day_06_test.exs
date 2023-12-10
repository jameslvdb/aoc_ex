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
    File.read!("../inputs/year_2022/day_06.txt")
    |> Day06.part_1()
  end

  test "finds the start of message marker" do
    str_1 = "mjqjpqmgbljsphdztnvjfqwrcgsmlb"
    str_2 = "bvwbjplbgvbhsrlpgdmjqwftvncz"
    str_3 = "nppdvjthqldpwncqszvftbrmjlhg"
    str_4 = "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg"
    str_5 = "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw"

    assert Day06.part_2(str_1) == 19
    assert Day06.part_2(str_2) == 23
    assert Day06.part_2(str_3) == 23
    assert Day06.part_2(str_4) == 29
    assert Day06.part_2(str_5) == 26
  end

  test "full part 2" do
    File.read!("../inputs/year_2022/day_06.txt")
    |> Day06.part_2()
  end
end
