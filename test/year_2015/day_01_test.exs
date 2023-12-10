defmodule Year2015.Day01Test do
  use ExUnit.Case
  alias Year2015.Day01

  test "part 1" do
    assert Day01.part_1("(())") == 0
    assert Day01.part_1("()()") == 0
    assert Day01.part_1("(((") == 3
    assert Day01.part_1("(()(()(") == 3
    assert Day01.part_1("))(((((") == 3
    assert Day01.part_1("())") == -1
    assert Day01.part_1("))(") == -1
    assert Day01.part_1(")))") == -3
  end

  test "part 2" do
    assert Day01.part_2(")") == 1
    assert Day01.part_2("()())") == 5
  end
end
