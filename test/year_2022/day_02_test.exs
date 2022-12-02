defmodule Year2022.Day02Test do
  use ExUnit.Case

  test "do something" do
    {:ok, input} = File.read("test/year_2022/day_02_test_input.txt")

    assert Year2022.Day02.part_1(input) == 15
  end

  test "score for result" do
    assert Year2022.Day02.score_for_result({:rock, :rock}) == 3
    assert Year2022.Day02.score_for_result({:paper, :paper}) == 3

    assert Year2022.Day02.score_for_result({:paper, :scissors}) == 6
    assert Year2022.Day02.score_for_result({:rock, :paper}) == 6
    assert Year2022.Day02.score_for_result({:scissors, :rock}) == 6

    assert Year2022.Day02.score_for_result({:paper, :rock}) == 0
    assert Year2022.Day02.score_for_result({:rock, :scissors}) == 0
    assert Year2022.Day02.score_for_result({:scissors, :paper}) == 0
  end

  test "score for move" do
    assert Year2022.Day02.score_for_move({:paper, :rock}) == 1
    assert Year2022.Day02.score_for_move({:scissors, :paper}) == 2
    assert Year2022.Day02.score_for_move({:rock, :scissors}) == 3
  end

  test "total round score" do
    assert Year2022.Day02.total_round_score({:rock, :rock}) == 3 + 1
    assert Year2022.Day02.total_round_score({:paper, :paper}) == 3 + 2
    assert Year2022.Day02.total_round_score({:scissors, :scissors}) == 3 + 3

    assert Year2022.Day02.total_round_score({:scissors, :rock}) == 6 + 1
    assert Year2022.Day02.total_round_score({:rock, :paper}) == 6 + 2
    assert Year2022.Day02.total_round_score({:paper, :scissors}) == 6 + 3

    assert Year2022.Day02.total_round_score({:paper, :rock}) == 0 + 1
    assert Year2022.Day02.total_round_score({:scissors, :paper}) == 0 + 2
    assert Year2022.Day02.total_round_score({:rock, :scissors}) == 0 + 3
  end

  test "move mapping" do
    assert Year2022.Day02.get_moves(["A", "X"]) == {:rock, :rock}
    assert Year2022.Day02.get_moves(["B", "Y"]) == {:paper, :paper}
    assert Year2022.Day02.get_moves(["C", "Z"]) == {:scissors, :scissors}
  end

  test "get intended match result" do
    assert Year2022.Day02.get_intended_result({:rock, "X"}) == {:rock, :loss}
    assert Year2022.Day02.get_intended_result({:rock, "Y"}) == {:rock, :draw}
    assert Year2022.Day02.get_intended_result({:rock, "Z"}) == {:rock, :win}
  end

  test "part 2" do
    {:ok, input} = File.read("test/year_2022/day_02_test_input.txt")

    assert Year2022.Day02.part_2(input) == 12
  end
end
