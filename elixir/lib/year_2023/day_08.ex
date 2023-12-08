defmodule Year2023.Day08 do
  @start_loc "AAA"
  @end_loc "ZZZ"

  def full_part_1() do
    InputHelper.input_for(2023, 8)
    |> part_1()
  end

  def part_1(input) do
    [steps, node_map] = parse_input(input)

    Stream.cycle(steps)
    |> Enum.reduce_while([@start_loc], fn step, acc -> traverse(step, node_map, acc) end)
    |> get_steps()
  end

  def full_part_2() do
    InputHelper.input_for(2023, 8)
    |> part_2()
  end

  def part_2(input) do
    [steps, node_map] = parse_input(input)

    starting_locs = starting_locations(node_map)

    Enum.map(starting_locs, fn loc ->
      Stream.cycle(steps)
      |> Enum.reduce_while([[loc]], fn step, acc ->
        traverse_as_ghost(step, node_map, acc)
      end)
      |> get_steps()
    end)
    |> least_common_multiple()
  end

  defp parse_input(input) do
    [steps, nodes] =
      input
      |> String.split("\n\n")

    steps = String.graphemes(steps)
    nodes = String.split(nodes, "\n", trim: true)

    node_map = Enum.reduce(nodes, %{}, fn node, acc -> add_node(acc, node) end)

    [steps, node_map]
  end

  def traverse(direction, node_map, positions) do
    current_pos = hd(positions)

    node_opts = Map.fetch!(node_map, current_pos)
    next_pos = Map.fetch!(node_opts, direction)

    if next_pos == @end_loc do
      {:halt, [next_pos | positions]}
    else
      {:cont, [next_pos | positions]}
    end
  end

  def traverse_as_ghost(direction, node_map, positions) do
    current_positions = hd(positions)

    new_positions =
      Enum.map(current_positions, fn pos ->
        get_in(node_map, [pos, direction])
      end)

    if(Enum.all?(new_positions, fn pos -> String.ends_with?(pos, "Z") end)) do
      {:halt, [new_positions | positions]}
    else
      {:cont, [new_positions | positions]}
    end
  end

  defp get_steps(list) do
    length(list) - 1
  end

  defp add_node(map, node_str) do
    node = String.slice(node_str, 0, 3)
    left_node = String.slice(node_str, 7, 3)
    right_node = String.slice(node_str, 12, 3)

    Map.put(map, node, %{
      "L" => left_node,
      "R" => right_node
    })
  end

  defp starting_locations(node_map) do
    Map.keys(node_map)
    |> Enum.filter(fn k -> String.ends_with?(k, "A") end)
  end

  def least_common_multiple(a, b) do
    numerator = a * b
    denominator = Integer.gcd(a, b)

    div(numerator, denominator)
  end

  def least_common_multiple([a, b | []]) do
    least_common_multiple(a, b)
  end

  def least_common_multiple([a, b | rest]) do
    tmp = least_common_multiple(a, b)
    least_common_multiple([tmp | rest])
  end
end
