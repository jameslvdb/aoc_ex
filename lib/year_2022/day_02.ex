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

  def part_2(input) do
    input
    |> split_by_newline()
    |> Enum.map(&String.split/1)
    |> Enum.map(&get_elf_move/1)
    |> Enum.map(&get_intended_result/1)
    |> Enum.map(&get_correct_move/1)
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

  def get_elf_move([elf_move, intended_result_key]) do
    elf_moves = %{"A" => :rock, "B" => :paper, "C" => :scissors}

    {elf_moves[elf_move], intended_result_key}
  end

  def get_intended_result({elf_move, intended_result_key}) do
    results = %{"X" => :loss, "Y" => :draw, "Z" => :win}
    {elf_move, results[intended_result_key]}
  end

  def get_correct_move({elf_move, intended_result}) do
    case {elf_move, intended_result} do
      {_, :win} -> find_winning_move(elf_move)
      {_, :draw} -> find_drawing_move(elf_move)
      {_, :loss} -> find_losing_move(elf_move)
    end
  end

  def find_winning_move(:rock), do: {:rock, :paper}
  def find_winning_move(:paper), do: {:paper, :scissors}
  def find_winning_move(:scissors), do: {:scissors, :rock}

  def find_drawing_move(move), do: {move, move}

  def find_losing_move(:rock), do: {:rock, :scissors}
  def find_losing_move(:paper), do: {:paper, :rock}
  def find_losing_move(:scissors), do: {:scissors, :paper}

  defp split_by_newline(input) do
    String.split(input, "\n", trim: true)
  end
end
