defmodule Year2023.Day07Test do
  alias Year2023.Day07
  use ExUnit.Case

  @card_order ~w(2 3 4 5 6 7 8 9 T J Q K A)

  # @joker_card_order ~w(J 2 3 4 5 6 7 8 9 T Q K A)

  @tag :skip
  test "part 1 example" do
    input = """
    32T3K 765
    T55J5 684
    KK677 28
    KTJJT 220
    QQQJA 483
    """

    assert Day07.part_1(input) == 6440
  end

  test "part 2 example" do
    input = """
    32T3K 765
    T55J5 684
    KK677 28
    KTJJT 220
    QQQJA 483
    """

    assert Day07.part_2(input) == 5905
  end

  test "card_values" do
    assert Day07.card_values("2359Q", @card_order) == [0, 1, 3, 7, 10]
  end

  test "card values sorting" do
    rank_2 = "KTJJT"
    rank_3 = "KK677"
    rank_4 = "T55J5"
    rank_5 = "QQQJA"

    assert Day07.card_values(rank_2, @card_order) < Day07.card_values(rank_3, @card_order)
    assert Day07.card_values(rank_4, @card_order) < Day07.card_values(rank_5, @card_order)
  end

  test "hand_type" do
    assert Day07.hand_type("AAAAA", :p1) == :five
    assert Day07.hand_type("44444", :p1) == :five
    assert Day07.hand_type("AAAA8", :p1) == :four
    assert Day07.hand_type("44455", :p1) == :full_house
    assert Day07.hand_type("56595", :p1) == :three
    assert Day07.hand_type("5588A", :p1) == :two_pair
  end

  test "part 2 hand type" do
    assert Day07.hand_type("AAAAA", :p2) == :five

    assert Day07.hand_type("AAAAJ", :p2) == :five
    assert Day07.hand_type("AAJKK", :p2) == :full_house
  end
end
