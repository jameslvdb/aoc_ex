defmodule Year2022.Day09 do
  def full_part_1() do
    InputHelper.input_for(2022, 9)
    |> String.split("\n")
    |> part_1()
  end

  def part_1(lines) do
    data = %{
      coords: %{
        head: %{x: 0, y: 0},
        tail: %{x: 0, y: 0}
      },
      visited: MapSet.new([%{x: 0, y: 0}])
    }

    result =
      Enum.map(lines, fn line ->
        [direction, steps] = String.split(line)
        [direction, String.to_integer(steps)]
      end)
      |> Enum.reduce(data, fn line, acc -> process_move(acc, line) end)

    Enum.count(result.visited)
  end

  def process_move(data, ["R", steps]) do
    Enum.reduce(1..steps, data, fn _step, acc ->
      update_in(acc.coords.head.x, &(&1 + 1))
      |> check_tail("R")
    end)
  end

  def process_move(data, ["L", steps]) do
    Enum.reduce(1..steps, data, fn _step, acc ->
      update_in(acc.coords.head.x, &(&1 - 1))
      |> check_tail("L")
    end)
  end

  def process_move(data, ["D", steps]) do
    Enum.reduce(1..steps, data, fn _step, acc ->
      update_in(acc.coords.head.y, &(&1 - 1))
      |> check_tail("D")
    end)
  end

  def process_move(data, ["U", steps]) do
    Enum.reduce(1..steps, data, fn _step, acc ->
      update_in(acc.coords.head.y, &(&1 + 1))
      |> check_tail("U")
    end)
  end

  def check_tail(data, move_direction) do
    if move_tail?(data.coords.head, data.coords.tail, move_direction) do
      update_tail(data, move_direction)
    else
      data
    end
  end

  def update_tail(data, "L") do
    %{x: head_x, y: head_y} = data.coords.head
    new_tail = %{x: head_x + 1, y: head_y}

    data = put_in(data.coords.tail, new_tail)
    put_in(data.visited, MapSet.put(data.visited, new_tail))
  end

  def update_tail(data, "R") do
    %{x: head_x, y: head_y} = data.coords.head
    new_tail = %{x: head_x - 1, y: head_y}

    data = put_in(data.coords.tail, new_tail)
    put_in(data.visited, MapSet.put(data.visited, new_tail))
  end

  def update_tail(data, "D") do
    %{x: head_x, y: head_y} = data.coords.head
    new_tail = %{x: head_x, y: head_y + 1}

    data = put_in(data.coords.tail, new_tail)
    put_in(data.visited, MapSet.put(data.visited, new_tail))
  end

  def update_tail(data, "U") do
    %{x: head_x, y: head_y} = data.coords.head
    new_tail = %{x: head_x, y: head_y - 1}

    data = put_in(data.coords.tail, new_tail)
    put_in(data.visited, MapSet.put(data.visited, new_tail))
  end

  def move_tail?(head_coords, tail_coords, last_move) do
    x_diff = abs(head_coords.x - tail_coords.x)
    y_diff = abs(head_coords.y - tail_coords.y)
    distance = Enum.max([x_diff, y_diff])
    distance > 1
  end
end
