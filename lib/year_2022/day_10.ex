defmodule Year2022.Day10 do
  def full_part_1() do
    InputHelper.input_for(2022, 10)
    |> String.split("\n")
    |> part_1()
  end

  def part_1(lines) do
    register_values(lines)
    |> signal_strength_sum()
  end

  def full_part_2() do
    InputHelper.input_for(2022, 10)
    |> String.split("\n")
    |> part_2()
  end

  def part_2(lines) do
    register_values(lines)
    |> draw_picture()
  end

  def register_values(lines) do
    register_values = [1]

    Enum.reduce(lines, register_values, fn line, acc -> process_line(acc, line) end)
    |> Enum.reverse()
  end

  def signal_strength_sum(register_values) do
    Enum.reduce([20, 60, 100, 140, 180, 220], 0, fn x, sum ->
      sum + x * Enum.at(register_values, x - 1)
    end)
  end

  def draw_picture(register_values) do
    chunks = Enum.chunk_every(register_values, 40)

    Enum.reduce(0..5, [], fn chunk, screen_lines ->
      [draw_line(Enum.at(chunks, chunk)) | screen_lines]
    end)
    |> Enum.reverse()
    |> Enum.map(&IO.inspect/1)
  end

  def draw_line(chunk) do
    Enum.reduce(0..39, [], fn pos, screen_line ->
      if draw?(pos, Enum.at(chunk, pos)), do: ["#" | screen_line], else: ["." | screen_line]
    end)
    |> Enum.reverse()
    |> Enum.join()
  end

  def draw?(cycle, value) do
    diff = abs(value - cycle)
    diff == 1 || diff == 0
  end

  def process_line(values, "noop") do
    head = hd(values)
    [head | values]
  end

  def process_line(values, addx_cmd) do
    add_value =
      String.split(addx_cmd)
      |> Enum.at(-1)
      |> String.to_integer()

    old_head = hd(values)
    value = old_head + add_value

    [value, old_head | values]
  end
end
