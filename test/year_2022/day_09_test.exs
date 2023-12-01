defmodule Year2022.Day09Test do
  use ExUnit.Case
  doctest Year2022.Day09
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
    # |> dbg()
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
         tail_moves: [],
         tail_list: [%{x: 0, y: 0}]
       },
       move_tail_right: %{
         coords: %{
           head: %{x: 1, y: 0},
           tail: %{x: 0, y: 0}
         },
         tail_moves: [],
         tail_list: [%{x: 0, y: 0}]
       },
       move_tail_left: %{
         coords: %{
           head: %{x: -1, y: 0},
           tail: %{x: 0, y: 0}
         },
         tail_moves: [],
         tail_list: [%{x: 0, y: 0}]
       },
       move_tail_up: %{
         coords: %{
           head: %{x: 0, y: 1},
           tail: %{x: 0, y: 0}
         },
         tail_moves: [],
         tail_list: [%{x: 0, y: 0}]
       },
       move_tail_down: %{
         coords: %{
           head: %{x: 0, y: -1},
           tail: %{x: 0, y: 0}
         },
         tail_moves: [],
         tail_list: [%{x: 0, y: 0}]
       },
       move_tail_diagonally: %{
         coords: %{
           head: %{x: -1, y: 1},
           tail: %{x: 0, y: 0}
         },
         tail_moves: [],
         tail_list: [%{x: 0, y: 0}]
       },
      }
    end

    @tag :skip
    test "it processes a right move", context do
      assert Day09.process_move(context[:data], %{x: 1, y: 0}).head_list == [%{x: 1, y: 0}]
    end

    @tag :skip
    test "it processes a left move", context do
      assert Day09.process_move(context[:data], %{x: -1, y: 0}).head_list == [%{x: -1, y: 0}]
    end

    @tag :skip
    test "it processes an up move", context do
      assert Day09.process_move(context[:data], %{x: 0, y: 1}).head_list == [%{x: 0, y: 1}]
    end

    @tag :skip
    test "it processes a down move", context do
      assert Day09.process_move(context[:data], %{x: 0, y: -1}).head_list == [%{x: 0, y: -1}]
    end

    test "it moves the tail right", context do
      result = Day09.process_move(context[:move_tail_right], %{x: 1, y: 0})

      assert result.coords == %{
               head: %{x: 2, y: 0},
               tail: %{x: 1, y: 0}
             }

      assert result.tail_moves == [%{x: 1, y: 0}]
      assert result.tail_list == [%{x: 1, y: 0}, %{x: 0, y: 0}]
    end

    test "it moves the tail left", context do
      result = Day09.process_move(context[:move_tail_left], %{x: -1, y: 0})

      assert result.coords == %{
               head: %{x: -2, y: 0},
               tail: %{x: -1, y: 0}
             }

      assert result.tail_moves == [%{x: -1, y: 0}]
      assert result.tail_list == [%{x: -1, y: 0}, %{x: 0, y: 0}]
    end

    test "it moves the tail up", context do
      result = Day09.process_move(context[:move_tail_up], %{x: 0, y: 1})

      assert result.coords == %{
               head: %{x: 0, y: 2},
               tail: %{x: 0, y: 1}
             }

      assert result.tail_moves == [%{x: 0, y: 1}]
      assert result.tail_list == [%{x: 0, y: 1}, %{x: 0, y: 0}]
    end

    test "it moves the tail down", context do
      result = Day09.process_move(context[:move_tail_down], %{x: 0, y: -1})

      assert result.coords == %{
               head: %{x: 0, y: -2},
               tail: %{x: 0, y: -1}
             }

      assert result.tail_moves == [%{x: 0, y: -1}]
      assert result.tail_list == [%{x: 0, y: -1}, %{x: 0, y: 0}]
    end

    test "it moves the tail to follow a diagonal", context do
      result = Day09.process_move(context[:move_tail_diagonally], %{x: 0, y: 1})

      assert result.coords == %{
               head: %{x: -1, y: 2},
               tail: %{x: -1, y: 1}
             }

      assert result.tail_moves == [%{x: -1, y: 0}, %{x: 0, y: 1}]
      assert result.tail_list == [%{x: -1, y: 1}, %{x: 0, y: 0}]
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
