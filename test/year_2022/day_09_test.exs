defmodule Year2022.Day09Test do
  use ExUnit.Case
  alias Year2022.Day09

  test "part_1" do
    input = [
      "R 4",
      "U 4",
      "L 3",
      "D 1",
      "R 4",
      "D 1",
      "L 5",
      "R 2"
    ]

    Day09.part_1(input)
    |> dbg()
  end

  test "part_2" do
    input = [
      "R 5",
      "U 8",
      "L 8",
      "D 3",
      "R 17",
      "D 10",
      "L 25",
      "U 20"
    ]

    Day09.part_2(input)
    |> dbg()
  end

  describe "part 2" do
    setup do
      {:ok,
       data: %{
         coords: %{
           head: %{x: 0, y: 0},
           tail: %{x: 0, y: 0}
         },
         head_list: [],
         visited: MapSet.new([%{x: 0, y: 0}])
       }}
    end

    test "it processes a right move", context do
      assert Day09.process_move(context[:data], %{x: 1, y: 0}).head_list == [%{x: 1, y: 0}]
    end

    test "it processes a left move", context do
      assert Day09.process_move(context[:data], %{x: -1, y: 0}).head_list == [%{x: -1, y: 0}]
    end

    test "it processes an up move", context do
      assert Day09.process_move(context[:data], %{x: 0, y: 1}).head_list == [%{x: 0, y: 1}]
    end

    test "it processes a down move", context do
      assert Day09.process_move(context[:data], %{x: 0, y: -1}).head_list == [%{x: 0, y: -1}]
    end
  end

  describe "line to move list" do
    test "move right" do
      assert Day09.line_to_move_list("R 3") == [
               %{x: 1, y: 0},
               %{x: 1, y: 0},
               %{x: 1, y: 0}
             ]
    end
  end
end
