defmodule Year2023.Day04Test do
  alias Year2023.Day04
  use ExUnit.Case

  describe "examples" do
    test "gets the right score for the part 1 example" do
      lines =
        InputHelper.example_input_for(2023, 4, 1)
        |> String.split("\n")

      scores = Day04.part_1(lines)
      assert scores == 13
    end

    test "gets the right number of cards for the part 2 example" do
      # Example input is the same
      lines =
        InputHelper.example_input_for(2023, 4, 1)
        |> String.split("\n")

      scores = Day04.part_2(lines)
      assert scores == 30
    end
  end

  test "winning_numbers" do
    line = "Game 1: 45 67 23 18 40 | 23 45 67 12 43"

    assert Day04.game_numbers(line) == [~w(45 67 23 18 40), ~w(23 45 67 12 43)]
  end

  test "find matches" do
    winning_numbers = ~w(1 3 5 7)
    my_numbers = ~w(2 4 5 7 8)
    assert Day04.find_winners([winning_numbers, my_numbers]) == ~w(5 7)
  end

  test "score of game" do
    assert Day04.score_of_game([]) == 0
    assert Day04.score_of_game(~w(1)) == 1
    assert Day04.score_of_game(~w(1 3)) == 2
    assert Day04.score_of_game(~w(1 3 4)) == 4
    assert Day04.score_of_game(~w(1 3 4 9)) == 8
  end

  test "get game ID" do
    assert Day04.game_id("Game 45: 34 56 | 56 78") == "45"
  end

  test "cards won" do
    assert Day04.cards_won(4, "5") == ~w(6 7 8 9)
    assert Day04.cards_won(1, "5") == ~w(6)
    assert Day04.cards_won(0, "5") == []
  end

  test "preprocess cards" do
    card = "Game 2: 1 2 3 4 | 1 3 5 7"

    expected_map = %{
      game_id: "2",
      winning_numbers: ~w(1 2 3 4),
      my_numbers: ~w(1 3 5 7)
    }

    assert Day04.preprocess_card(card) == expected_map
  end

  describe "count_initial_card" do
    test "initializes an entry in state with 1" do
      initial_state = %{"1" => 1, "2" => 2}
      expected_state = %{"1" => 1, "2" => 2, "3" => 1}
      assert Day04.count_initial_card(initial_state, "3") == expected_state
    end

    test "increments a pre-existing entry" do
      initial_state = %{"1" => 1, "2" => 2, "3" => 1}
      expected_state = %{"1" => 1, "2" => 2, "3" => 2}
      assert Day04.count_initial_card(initial_state, "3") == expected_state
    end
  end

  describe "add_winners" do
    test "should update the state with all new winners" do
      initial_state = %{
        "1" => 1,
        "2" => 1,
        "3" => 2
      }

      game_id = "1"
      winners = ~w(2 3 4 5)

      expected_state = %{
        "1" => 1,
        "2" => 2,
        "3" => 3,
        "4" => 1,
        "5" => 1
      }

      assert Day04.add_winners(initial_state, game_id, winners) == expected_state
    end
  end

  describe "process_card" do
    test "for a single card" do
      initial_state = %{}
      id = "1"
      winning_nums = ~w(1 2 3)
      my_nums = ~w(2 4)

      expected_state = %{
        "1" => 1,
        "2" => 1
      }

      assert Day04.process_card(initial_state, %{
               game_id: id,
               winning_numbers: winning_nums,
               my_numbers: my_nums
             }) == expected_state
    end

    test "for multiple cards" do
      initial_state = %{"1" => 4, "2" => 2}
      id = "1"
      winning_nums = ~w(1 2 3)
      my_nums = ~w(2 4)

      expected_state = %{
        "1" => 5,
        "2" => 7
      }

      assert Day04.process_card(initial_state, %{
               game_id: id,
               winning_numbers: winning_nums,
               my_numbers: my_nums
             }) == expected_state
    end
  end
end
