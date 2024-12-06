defmodule Year2024.Day05 do
  def solve() do
    input = InputHelper.input_for(2024, 5)
    IO.puts("Part 1: #{part_1(input)}")
    IO.puts("Part 2: #{part_2(input)}")
  end

  def setup(raw_input) do
    [raw_ordering_rules, raw_updates] = String.split(raw_input, "\n\n")

    ordering_rules =
      raw_ordering_rules
      |> String.split("\n", trim: true)

    updates =
      raw_updates
      |> String.split("\n", trim: true)

    {ordering_rules(ordering_rules), updates(updates)}
  end

  def ordering_rules(raw_rules) do
    raw_rules
    |> Enum.map(&String.split(&1, "|", trim: true))
  end

  def updates(list) do
    list
    |> Enum.map(&String.split(&1, ",", trim: true))
  end

  def part_1(input) do
    {ordering_rules, updates} =
      input
      |> setup()

    Enum.filter(updates, fn update ->
      valid_update?(update, ordering_rules)
    end)
    |> Enum.map(&middle_number/1)
    |> Enum.sum()
  end

  def part_2(input) do
    {ordering_rules, updates} =
      input
      |> setup()

    Enum.reject(updates, fn update ->
      valid_update?(update, ordering_rules)
    end)
    |> Enum.map(&fix_ordering(&1, ordering_rules))
    |> Enum.map(&middle_number/1)
    |> Enum.sum()
  end

  def valid_update?(update, page_rules) do
    [first_page | rest] = update
    _valid_update?(first_page, rest, page_rules)
  end

  defp _valid_update?(_page, [], _page_rules) do
    true
  end

  defp _valid_update?(page, rest, page_rules) do
    all_updates_valid? =
      Enum.map(rest, fn next_page ->
        sorting_function(page_rules, [page, next_page])
      end)
      |> Enum.all?(& &1)

    [next_page | rest] = rest

    all_updates_valid? && _valid_update?(next_page, rest, page_rules)
  end

  def sorting_function(page_rules, [x, y]) do
    cond do
      [x, y] in page_rules -> true
      [y, x] in page_rules -> false
      true -> true
    end
  end

  def fix_ordering(update, sorting_rules) do
    Enum.sort(update, fn x, y ->
      sorting_function(sorting_rules, [x, y])
    end)
  end

  def middle_number(list) do
    Enum.at(list, div(Enum.count(list), 2))
    |> String.to_integer()
  end

  def test_input() do
    """
    47|53
    97|13
    97|61
    97|47
    75|29
    61|13
    75|53
    29|13
    97|29
    53|29
    61|53
    97|53
    61|29
    47|13
    75|47
    97|75
    47|61
    75|61
    47|29
    75|13
    53|13

    75,47,61,53,29
    97,61,53,29,13
    75,29,13
    75,97,47,61,53
    61,13,29
    97,13,75,29,47
    """
  end
end
