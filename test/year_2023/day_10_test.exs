defmodule Year2023.Day10Test do
  alias Year2023.Day10
  use ExUnit.Case

  # test "part 1 example" do
  #   input = """
  #   .....
  #   .S-7.
  #   .|.|.
  #   .L-J.
  #   .....
  #   """
  # end

  test "build map" do
    input = [
      "..",
      ".S"
    ]

    assert Day10.build_map(input) == %{
             {0, 0} => ".",
             {0, 1} => ".",
             {1, 0} => ".",
             {1, 1} => "S"
           }
  end

  test "filter out ground" do
    map = %{
      {0, 0} => ".",
      {0, 1} => ".",
      {1, 0} => ".",
      {1, 1} => "S"
    }

    assert Day10.filter_ground(map) == %{{1, 1} => "S"}
  end

  test "get connected pipes" do
    input = """
    .....
    .S-7.
    .|.|.
    .L-J.
    .....
    """

    map =
      Day10.parse_input(input)
      |> Day10.build_map()
      |> Day10.filter_ground()

    assert map == nil
  end

  test "enrich with coordinates" do
    input = [
      "..",
      ".S"
    ]

    assert Day10.enrich_input_with_coordinates(input) == [
             [
               {".", {0, 0}},
               {".", {0, 1}}
             ],
             [
               {".", {1, 0}},
               {"S", {1, 1}}
             ]
           ]
  end

  test "coordinates of animal" do
    input = """
    .....
    .F-7.
    .|.S.
    .L-J.
    .....
    """

    map =
      Day10.parse_input(input)
      |> Day10.build_map()
      |> Day10.filter_ground()

    assert Day10.position_of_animal(map) == {2, 3}
  end

  test "coordinates of connected pipes" do
    input = """
    .....
    .S-7.
    .|.|.
    .L-J.
    .....
    """

    map =
      Day10.parse_input(input)
      |> Day10.build_map()
      |> Day10.filter_ground()

    assert Day10.connected_pipes(map, {1, 1}) == [
             {1, 2},
             {1, 3},
             {2, 1},
             {2, 3},
             {3, 1},
             {3, 2},
             {3, 3}
           ]
  end
end
