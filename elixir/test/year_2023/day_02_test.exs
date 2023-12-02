defmodule Year2023.Day02Test do
  alias Year2023.Day02
  use ExUnit.Case

  describe "example cases" do
    test "it should return the correct result for the example" do
      lines =
        InputHelper.example_input_for(2023, 2, 1)
        |> String.split("\n")

      assert Day02.process_games(lines) == 8
    end
  end

  test "should return the game ID" do
    assert Day02.game_id("Game 4: blue: 4") == 4
    assert Day02.game_id("Game 26: blue: 4") == 26
    assert Day02.game_id("Game 100: blue: 4") == 100
  end

  test "it removes the game identifier" do
    assert Day02.trim_game_id("Game 4: 2 blue") == "2 blue"
  end

  test "it should split up the different draws" do
    assert Day02.split_draws("2 green, 4 blue; 1 green") == ["2 green, 4 blue", "1 green"]
  end

  test "it should split up the draws by color" do
    assert Day02.split_colors("1 green, 2 red, 4 blue") == ["1 green", "2 red", "4 blue"]
  end

  test "it should process the game into a list of draws" do
    valid_game = "Game 1: 1 blue, 3 green; 3 red, 6 green"
    assert Day02.process_game(valid_game) == 1

    invalid_game = "Game 2: 50 blue, 3 red; 3 blue, 6 green"
    assert Day02.process_game(invalid_game) == 0
  end

  test "it should validate a draw from a string" do
    game = "5 blue"
    assert Day02.validate_draw("5 blue") == true
    assert Day02.validate_draw("18 blue") == false
  end

  test "it should validate a single draw" do
    assert Day02.validate_draw(3, "blue") == true
    assert Day02.validate_draw(14, "blue") == true
    assert Day02.validate_draw(15, "blue") == false
    assert Day02.validate_draw(3, "green") == true
    assert Day02.validate_draw(13, "green") == true
    assert Day02.validate_draw(14, "green") == false
    assert Day02.validate_draw(1, "red") == true
    assert Day02.validate_draw(12, "red") == true
    assert Day02.validate_draw(13, "red") == false
  end
end
