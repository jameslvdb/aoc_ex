defmodule Year2022.Day08 do
  def full_part_1() do
    InputHelper.input_for(2022, 8)
    |> String.split("\n")
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(fn line -> Enum.map(line, &String.to_integer/1) end)
    |> part_1()
  end

  def part_1(tree_matrix) do
    transposed_trees = transpose(tree_matrix)

    trees_visible_horizontally =
      visible_trees_in_matrix(tree_matrix)
      |> MapSet.new()

    trees_visible_vertically =
      visible_trees_in_matrix(transposed_trees)
      |> Enum.map(fn {x, y} -> {y, x} end)
      |> MapSet.new()

    MapSet.union(trees_visible_horizontally, trees_visible_vertically)
    |> Enum.count()
  end

  def visible_trees_in_matrix(matrix) do
    Enum.with_index(matrix)
    |> Enum.map(fn {line, outer_index} -> visible_trees_in_line(line, outer_index) end)
    |> List.flatten()
  end

  def visible_trees_in_line(line, outer_index) do
    {_, visible} =
      Enum.map_reduce(0..(length(line) - 1), [], fn tree, visible_trees ->
        if visible?(line, tree),
          do: {line, [{outer_index, tree} | visible_trees]},
          else: {line, visible_trees}
      end)

    Enum.sort(visible)
  end

  def visible?(_line, 0), do: true

  def visible?(line, pos) do
    {left, tree, right} = split_around(line, pos)

    visible_left?(left, tree) || visible_right?(right, tree)
  end

  defp visible_left?(left, tree) do
    Enum.all?(left, fn x -> x < tree end)
  end

  defp visible_right?(right, tree) do
    Enum.all?(right, fn x -> x < tree end)
  end

  def full_part_2() do
    InputHelper.input_for(2022, 8)
    |> String.split("\n")
    |> Enum.map(&String.graphemes/1)
    |> Enum.map(fn line -> Enum.map(line, &String.to_integer/1) end)
    |> part_2()
  end

  def part_2(matrix) do
    scenic_scores_for_matrix(matrix)
    |> List.flatten()
    |> Enum.max()
  end

  def scenic_scores_for_matrix(matrix) do
    transposed_trees = transpose(matrix)

    scores = Enum.map(matrix, &scenic_scores_for_line/1)

    transposed_scores = Enum.map(transposed_trees, &scenic_scores_for_line/1)

    Enum.map(0..(length(scores) - 1), fn i ->
      Enum.zip(Enum.at(transpose(scores), i), Enum.at(transposed_scores, i))
      |> Enum.map(&Tuple.to_list/1)
      |> Enum.map(&List.flatten/1)
      |> Enum.map(fn list -> Enum.reduce(list, fn x, acc -> x * acc end) end)
    end)
  end

  def scenic_scores_for_line(line) do
    Enum.map(0..(length(line) - 1), fn tree ->
      scenic_score(line, tree)
    end)
  end

  defp transpose(matrix) do
    Enum.zip(matrix)
    |> Enum.map(&Tuple.to_list/1)
  end

  def scenic_score(line, pos) do
    {left, tree, right} = split_around(line, pos)

    [scenic_score_side(Enum.reverse(left), tree), scenic_score_side(right, tree)]
  end

  defp scenic_score_side([], _), do: 0

  defp scenic_score_side(trees, tree) do
    index = Enum.find_index(trees, fn x -> x >= tree end)
    if is_nil(index), do: length(trees), else: index + 1
  end

  defp split_around(line, position) do
    {left, right} = Enum.split(line, position)
    [tree | right] = right
    {left, tree, right}
  end
end
