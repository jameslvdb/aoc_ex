defmodule Year2022.Day11Test do
  alias Year2022.Day11
  use ExUnit.Case

  test "it can parse one monkey's attributes" do
    input = test_input()

    String.split(input, "\n")
    |> Enum.map(&String.trim/1)

    # |> Enum.map(fn x -> IO.puts("\"#{x}\"") end)
  end

  test "it parses a monkey number" do
    assert Day11.monkey_number("Monkey 0:") == 0
    assert Day11.monkey_number("Monkey 4:") == 4
  end

  test "it parses a monkey's starting items" do
    assert Day11.starting_items("Starting items: 79, 98") == [79, 98]
  end

  test "it generates an anonymous function for the monkey's operation" do
    operation_fn = Day11.monkey_operation("Operation: new = old * 19")
    assert operation_fn.(2) == 38
    operation_fn = Day11.monkey_operation("Operation: new = old + old")
    assert operation_fn.(3) == 6
    operation_fn = Day11.monkey_operation("Operation: new = old - 7")
    assert operation_fn.(14) == 7
  end

  test "it generates an anonymous function for the test function" do
    test_fn = Day11.test_function("Test: divisible by 5")
    assert test_fn.(15) == 0
    assert test_fn.(8) == 3
  end

  defp test_input() do
    input = """
    Monkey 0:
      Starting items: 79, 98
      Operation: new = old * 19
      Test: divisible by 23
        If true: throw to monkey 2
        If false: throw to monkey 3

    Monkey 1:
      Starting items: 54, 65, 75, 74
      Operation: new = old + 6
      Test: divisible by 19
        If true: throw to monkey 2
        If false: throw to monkey 0

    Monkey 2:
      Starting items: 79, 60, 97
      Operation: new = old * old
      Test: divisible by 13
        If true: throw to monkey 1
        If false: throw to monkey 3

    Monkey 3:
      Starting items: 74
      Operation: new = old + 3
      Test: divisible by 17
        If true: throw to monkey 0
        If false: throw to monkey 1
    """
  end
end
