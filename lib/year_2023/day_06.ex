defmodule Year2023.Day06 do
  def full_part_1() do
    InputHelper.input_for(2023, 6)
    |> part_1()
  end

  def part_1(input) do
    lines = String.split(input, "\n", trim: true)

    [
      "Time:" <> time_raw,
      "Distance:" <> distance_raw
    ] = lines

    times = parse_line(time_raw)
    distances = parse_line(distance_raw)

    Enum.zip([times, distances])
    |> Enum.map(&number_of_winning_times/1)
    |> Enum.product()
  end

  def full_part_2() do
    InputHelper.input_for(2023, 6)
    |> part_2()
  end

  def part_2(input) do
    lines = String.split(input, "\n", trim: true)

    [
      "Time:" <> time_raw,
      "Distance:" <> distance_raw
    ] = lines

    time = part_2_parse_line(time_raw)
    distance = part_2_parse_line(distance_raw)

    number_of_winning_times({time, distance})
  end

  defp parse_line(line) do
    String.split(line, ~r/\s/, trim: true)
    |> Enum.map(&String.to_integer/1)
  end

  defp part_2_parse_line(line) do
    String.split(line, ~r/\s/, trim: true)
    |> Enum.join()
    |> String.to_integer()
  end

  def number_of_winning_times(race) do
    shortest = lowest_winner(race)
    longest = longest_winner(race)

    longest - shortest + 1
  end

  def lowest_winner({time, distance}) do
    times = 0..time

    Stream.filter(times, fn x -> test_game(x, {time, distance}) end)
    |> Enum.at(0)
  end

  def longest_winner({time, distance}) do
    times = time..0

    Stream.filter(times, fn x -> test_game(x, {time, distance}) end)
    |> Enum.at(0)
  end

  def test_game(velocity, {time, distance}) do
    moving_time = time - velocity
    velocity * moving_time > distance
  end
end
