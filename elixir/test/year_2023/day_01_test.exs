defmodule Year2023.Day01Test do
  alias Year2023.Day01
  use ExUnit.Case

  # xtest "gets valid numbers in a string" do
  #   assert Day01.numbers_in_line("1ab45") == ~w(1 4 5)
  #   assert Day01.numbers_in_line("abc") == []
  #   assert Day01.numbers_in_line("ab34dsf") == ~w(3 4)
  #   assert Day01.numbers_in_line("one4three") == ~w(1 4 3)
  #   assert Day01.numbers_in_line("two1nine") == ~w(2 1 9)
  #   assert Day01.numbers_in_line("abcone2threexyz") == ~w(1 2 3)
  #   assert Day01.numbers_in_line("xtwone3four") == ~w(2 3 4)
  #   assert Day01.numbers_in_line("4nineeightseven2") == ~w(4 9 8 7 2)
  #   assert Day01.numbers_in_line("zoneight234") == ~w(1 8 2 3 4)
  # end

  # test "gets correct value for multiple numbers" do
  #   assert Day01.line_value(~w(3 4 6)) == 36
  #   assert Day01.line_value(~w(3)) == 33
  #   assert Day01.line_value([]) == nil
  # end

  # test "replaces word instances with numbers" do
  #   assert Day01.replace_words("one3four") == "134"
  # end

  describe "part 1" do
    test "gets correct numbers from a line" do
      assert Day01.numbers_in_line("1bch54", :p1) == ~w(1 5 4)
    end

    test "it does not pick up spelled-out numbers" do
      assert Day01.numbers_in_line("1bch54three", :p1) == ~w(1 5 4)
    end

    test "it returns the first and last numbers joined as an Integer" do
      assert Day01.line_value(~w(1 2 3)) == 13
    end

    test "it returns the same number twice if only one number is present" do
      assert Day01.line_value(~w(1)) == 11
      assert Day01.line_value(~w(5)) == 55
    end

    test "it gets the correct value for the part 1 example" do
      lines =
        InputHelper.example_input_for(2023, 1, 1)
        |> String.split("\n")

      assert Day01.part_1(lines) == 142
    end
  end

  describe "part 2" do
    test "it gets the first number" do
      assert Day01.first_number("abc123") == "1"
      assert Day01.first_number("facienioedfmtwo239290fdkloiesmcthree") == "2"
    end

    test "it gets the last number" do
      assert Day01.last_number("abc123") == "3"
      assert Day01.last_number("fd5th") == "5"
      assert Day01.last_number("onefour6hdemo67threefiv") == "3"
    end

    test "it concatenates the first and last number" do
      assert Day01.number_for_line("1") == 11
      assert Day01.number_for_line("12") == 12
      assert Day01.number_for_line("1b2") == 12
      assert Day01.number_for_line("132") == 12
      assert Day01.number_for_line("onethree") == 13
      assert Day01.number_for_line("oneight") == 18
    end

    test "it gets the correct value for the part 2 example" do
      lines =
        InputHelper.example_input_for(2023, 1, 2)
        |> String.split("\n")

      assert Day01.part_2(lines) == 281
    end
  end

  test "gets correct number strings for each part" do
    assert Day01.valid_numbers(:p1) == ~w(1 2 3 4 5 6 7 8 9 0)

    assert Day01.valid_numbers(:p2) ==
             ~w(1 2 3 4 5 6 7 8 9 0 one two three four five six seven eight nine zero)
  end
end
