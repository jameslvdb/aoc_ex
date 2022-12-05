defmodule Year2022.Day05Test do
  alias Year2022.Day05
  use ExUnit.Case

  test "split by row" do
    assert Day05.split_by_row("            [C]         [N] [R]") == [
             "",
             "",
             "",
             "C",
             "",
             "",
             "N",
             "R",
             ""
           ]
  end

  test "build move" do
    assert Day05.build_move("move 11 from 4 to 3") == %{count: 11, from: 3, to: 2}
  end

  # test "do part 1" do
  #   Day05.full_part_1()
  # end

  test "perform moves" do
    stacks = [
      ~w(N Z),
      ~w(D C M),
      ~w(P)
    ]

    moves = [
      "move 1 from 2 to 1",
      "move 3 from 1 to 3",
      "move 2 from 2 to 1",
      "move 1 from 1 to 2"
    ]

    # For every move in moves, I need to:
    # Perform the move on the stacks array
    # Bind stacks to the result

    parsed_moves =
      Enum.map(moves, &Day05.build_move/1)
      |> dbg()

    Enum.reduce(parsed_moves, stacks, fn move, acc -> Day05.perform_move(move, acc) end)
    |> Enum.map(&hd/1)
    |> Enum.join()
    |> dbg()
  end
end
