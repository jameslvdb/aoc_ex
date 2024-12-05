defmodule Year2024.Day02 do
  def puzzle_input() do
    InputHelper.input_for(2024, 2)
  end

  def part_1() do
    puzzle_input()
    |> process_input()
    |> Enum.map(&convert_to_steps/1)
    |> Enum.filter(&is_report_safe?/1)
    |> Enum.count()
  end

  def part_2() do
    puzzle_input()
    |> process_input()
    |> Enum.map(fn report ->
      if is_report_safe?(report) do
        true
      else
        {_, permutations} = report_permutations(report)

        permutations
        |> Enum.map(&convert_to_steps/1)
        |> Enum.any?(&is_report_safe?/1)
      end
    end)
    |> Enum.filter(fn x -> x end)
    |> Enum.count()
  end

  def process_input(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(&String.split/1)
    |> Enum.map(fn report ->
      Enum.map(report, &String.to_integer/1)
    end)
  end

  def is_report_safe?(report) do
    Enum.all?([
      all_steps_positive?(report) || all_steps_negative?(report),
      all_steps_less_than_3?(report)
    ])
  end

  def convert_to_steps(report) do
    report
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.map(fn [x, y] -> x - y end)
  end

  defp all_steps_positive?(list) do
    Enum.all?(list, fn x -> x > 0 end)
  end

  defp all_steps_negative?(list) do
    Enum.all?(list, fn x -> x < 0 end)
  end

  defp all_steps_less_than_3?(list) do
    Enum.map(list, &abs/1)
    |> Enum.all?(fn x -> x <= 3 end)
  end

  def report_permutations(report) do
    Enum.reduce_while(report, {0, []}, fn _x, {index, permutations} ->
      if index == Enum.count(report) do
        {:halt, permutations}
      else
        {:cont, {index + 1, [List.delete_at(report, index) | permutations]}}
      end
    end)
  end
end
