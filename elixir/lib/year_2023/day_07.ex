defmodule Year2023.Day07 do
  @card_order ~w(2 3 4 5 6 7 8 9 T J Q K A)

  @hand_values %{
    five: 6,
    four: 5,
    full_house: 4,
    three: 3,
    two_pair: 2,
    pair: 1,
    high_card: 0
  }

  def full_part_1() do
    InputHelper.input_for(2023, 7)
    |> part_1()
  end

  def part_1(input) do
    input
    |> parse_input()
    |> Enum.map(&enrich_with_sort_structure/1)
    |> Enum.sort(&(&1.sort_structure < &2.sort_structure))
    |> total_winnings()
  end

  defp parse_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split/1)
    |> Enum.map(fn [hand, bid] -> %{hand: hand, bid: String.to_integer(bid)} end)
  end

  def total_winnings(hands) do
    hands_with_index = Enum.with_index(hands)

    Enum.map(hands_with_index, &hand_winnings/1)
    |> Enum.sum()
  end

  defp hand_winnings({hand, index}) do
    dbg({hand.hand, hand.bid, index})
    hand.bid * (index + 1)
  end

  def enrich_with_sort_structure(hand_map) do
    structure = {
      @hand_values[hand_type(hand_map.hand)],
      card_values(hand_map.hand)
    }

    Map.put(hand_map, :sort_structure, structure)
  end

  def hand_type(hand) do
    card_counts =
      String.graphemes(hand)
      |> Enum.frequencies()
      |> Map.values()
      |> Enum.sort(:desc)

    case card_counts do
      [5] ->
        :five

      [4, 1] ->
        :four

      [3, 2] ->
        :full_house

      [3, 1, 1] ->
        :three

      [2, 2, 1] ->
        :two_pair

      [2, 1, 1, 1] ->
        :pair

      [1, 1, 1, 1, 1] ->
        :high_card
    end
  end

  def card_values(str) do
    String.graphemes(str)
    |> Enum.map(fn my_card -> Enum.find_index(@card_order, fn x -> x == my_card end) end)
  end
end
