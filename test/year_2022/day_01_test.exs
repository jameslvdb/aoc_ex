defmodule Year2022.Day01Test do
  alias Year2022.Day01, as: Subject
  use ExUnit.Case

  test "gets inputs" do
    {:ok, input} = File.read("test/year_2022/day_01_test_input.txt")

    assert Subject.part_1(input) == 7000 + 8000 + 9000
  end
end
