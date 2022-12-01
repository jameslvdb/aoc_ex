defmodule Year2022.Day01Test do
  alias Year2022.Day01, as: Subject
  use ExUnit.Case

  test "gets inputs" do
    {:ok, input} = File.read("test/year_2022/day_01_test_input.txt")
    expected_arrays = [~w(1000 2000 3000), ~w(4000), ~w(5000 6000), ~w(7000 8000 9000), ~w(10000)]
    IO.inspect(input)
    IO.inspect(expected_arrays)
    assert Subject.part_1(input) == expected_arrays
  end
end
