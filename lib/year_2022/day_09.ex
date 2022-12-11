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
      head_list: [],
      tail_moves: [],
      tail_list: [%{x: 0, y: 0}]
    }

    head_move_list =
      Enum.map(lines, &line_to_move_list/1)
      |> List.flatten()

    result = Enum.reduce(head_move_list, data, fn line, acc -> process_move(acc, line) end)

    Enum.uniq(result.tail_list)
    |> Enum.count()
  end

  def part_2(lines) do
    data = %{
      coords: %{
        head: %{x: 0, y: 0},
        tail: %{x: 0, y: 0}
      },
      head_list: [],
      tail_moves: [],
      tail_list: [%{x: 0, y: 0}]
    }

    head_move_list =
      Enum.map(lines, &line_to_move_list/1)
      |> Enum.flatten()
  end

  def line_to_move_list(line) do
    [direction, steps] = String.split(line)

    steps = String.to_integer(steps)

    case direction do
      "R" ->
        Enum.map(1..steps, fn _x -> %{x: 1, y: 0} end)

      "L" ->
        Enum.map(1..steps, fn _x -> %{x: -1, y: 0} end)

      "U" ->
        Enum.map(1..steps, fn _x -> %{x: 0, y: 1} end)

      "D" ->
        Enum.map(1..steps, fn _x -> %{x: 0, y: -1} end)
    end
  end

  def build_head_move_list(lines, data) do
    Enum.map(lines, fn line ->
      [direction, steps] = String.split(line)
      [direction, String.to_integer(steps)]
    end)
    |> Enum.reduce(data, fn line, acc -> process_move(acc, line) end)
  end

  def process_move(data, %{x: 1, y: 0}) do
    update_in(data.coords.head.x, &(&1 + 1))
    |> check_tail("R")
  end

  def process_move(data, %{x: -1, y: 0}) do
    update_in(data.coords.head.x, &(&1 - 1))
    |> check_tail("L")
  end

  def process_move(data, %{x: 0, y: -1}) do
    update_in(data.coords.head.y, &(&1 - 1))
    |> check_tail("D")
  end

  def process_move(data, %{x: 0, y: 1}) do
    update_in(data.coords.head.y, &(&1 + 1))
    |> check_tail("U")
  end

  def check_tail(data, move_direction) do
    if move_tail?(data.coords.head, data.coords.tail) do
      update_tail(data, move_direction)
    else
      data
    end
  end

  def update_tail(data, "L") do
    %{x: head_x, y: head_y} = data.coords.head
    new_tail = %{x: head_x + 1, y: head_y}

    data = put_in(data.coords.tail, new_tail)
    data = put_in(data.tail_list, [new_tail | data.tail_list])
    put_in(data.tail_moves, [%{x: -1, y: 0} | data.tail_moves])
  end

  def update_tail(data, "R") do
    %{x: head_x, y: head_y} = data.coords.head
    new_tail = %{x: head_x - 1, y: head_y}

    data = put_in(data.coords.tail, new_tail)
    data = put_in(data.tail_list, [new_tail | data.tail_list])
    put_in(data.tail_moves, [%{x: 1, y: 0} | data.tail_moves])
  end

  def update_tail(data, "D") do
    %{x: head_x, y: head_y} = data.coords.head
    new_tail = %{x: head_x, y: head_y + 1}

    data = put_in(data.coords.tail, new_tail)
    data = put_in(data.tail_list, [new_tail | data.tail_list])
    put_in(data.tail_moves, [%{x: 0, y: -1} | data.tail_moves])
  end

  def update_tail(data, "U") do
    %{x: head_x, y: head_y} = data.coords.head
    new_tail = %{x: head_x, y: head_y - 1}

    data = put_in(data.coords.tail, new_tail)
    data = put_in(data.tail_list, [new_tail | data.tail_list])
    put_in(data.tail_moves, [%{x: 0, y: 1} | data.tail_moves])
  end

  def move_tail?(head_coords, tail_coords) do
    x_diff = abs(head_coords.x - tail_coords.x)
    y_diff = abs(head_coords.y - tail_coords.y)
    distance = Enum.max([x_diff, y_diff])
    distance > 1
  end
end
