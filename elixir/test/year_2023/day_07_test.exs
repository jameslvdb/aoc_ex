defmodule Year2023.Day07Test do
  alias Year2023.Day07
  use ExUnit.Case

  test "part 1 example " do
    input = """
    32T3K 765
    T55J5 684
    KK677 28
    KTJJT 220
    QQQJA 483
    """

    assert Day07.part_1(input) == 6440
  end

  test "card_values" do
    assert Day07.card_values("2359Q") == [0, 1, 3, 7, 10]
  end

  test "card values sorting" do
    rank_2 = "KTJJT"
    rank_3 = "KK677"
    rank_4 = "T55J5"
    rank_5 = "QQQJA"

    assert Day07.card_values(rank_2) < Day07.card_values(rank_3)
    assert Day07.card_values(rank_4) < Day07.card_values(rank_5)
  end

  test "hand_type" do
    assert Day07.hand_type("AAAAA") == :five
    assert Day07.hand_type("44444") == :five
    assert Day07.hand_type("AAAA8") == :four
    assert Day07.hand_type("44455") == :full_house
    assert Day07.hand_type("56595") == :three
    assert Day07.hand_type("5588A") == :two_pair
  end
end
