defmodule Year2022.Day02 do
  @moduledoc """
  https://adventofcode.com/2022/day/2
  """

  def part_1(input) do
    input
    |> split_by_newline()
    |> Enum.map(&String.split/1)
    |> Enum.map(&get_moves/1)
    |> Enum.map(&total_round_score/1)
    |> Enum.sum()
  end

  def total_round_score(moves) do
    score_for_result(moves) + score_for_move(moves)
  end

  # draw case
  def score_for_result({move, move}) do
    3
  end

  def score_for_result({elf_move, player_move}) do
    case {elf_move, player_move} do
      {:rock, :paper} -> 6
      {:paper, :scissors} -> 6
      {:scissors, :rock} -> 6
      _ -> 0
    end
  end

  def score_for_move({_, move}) do
    move_values = %{rock: 1, paper: 2, scissors: 3}

    move_values[move]
  end

  def get_moves([elf_move, player_move]) do
    elf_moves = %{"A" => :rock, "B" => :paper, "C" => :scissors}
    player_moves = %{"X" => :rock, "Y" => :paper, "Z" => :scissors}

    {elf_moves[elf_move], player_moves[player_move]}
  end

  defp split_by_newline(input) do
    String.split(input, "\n", trim: true)
  end
end
