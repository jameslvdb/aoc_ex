defmodule Year2022.Day04Test do
  use ExUnit.Case
  alias Year2022.Day04

  test "part 1" do
    assignments = [
      "2-4,6-8",
      "2-3,4-5",
      "5-7,7-9",
      "2-8,3-7",
      "6-6,4-6",
      "2-6,4-8"
    ]

    assert Day04.part_1(assignments) == 2
  end

  test "part 2" do
    assignments = [
      "2-4,6-8",
      "2-3,4-5",
      "5-7,7-9",
      "2-8,3-7",
      "6-6,4-6",
      "2-6,4-8"
    ]

    assert Day04.part_2(assignments) == 4
  end

  test "create_ranges" do
	assert Day04.create_ranges("4-6") == Range.new(4, 6)
  end

  test "check ranges" do
	assert Day04.check_ranges([1..20, 4..8]) == true
	assert Day04.check_ranges([6..20, 1..30]) == true
	assert Day04.check_ranges([4..6, 6..6]) == true

	assert Day04.check_ranges([4..6, 6..8]) == false
	assert Day04.check_ranges([4..6, 5..8]) == false
	assert Day04.check_ranges([4..6, 10..15]) == false
	assert Day04.check_ranges([5..8, 1..3]) == false
  end

  test "chack range overlap" do
	assert Day04.check_range_overlap([1..10, 5..15]) == true
  end
end
