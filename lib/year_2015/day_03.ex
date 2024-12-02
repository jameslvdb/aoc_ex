defmodule Year2015.Day03 do
  def part_1() do
    state = %{
      houses: MapSet.new([{0, 0}]),
      position: {0, 0}
    }

    final_state =
      InputHelper.input_for(2015, 3)
      |> String.graphemes()
      |> Enum.reduce(state, fn move, state -> process_move(move, state) end)

    Enum.count(final_state.houses)
  end

  def part_2() do
    state = %{
      houses: MapSet.new([{0, 0}]),
      position: {0, 0}
    }

    moves =
      InputHelper.input_for(2015, 3)
      |> String.graphemes()

    santa_houses =
      santa_moves(moves)
      |> Enum.reduce(state, fn move, state -> process_move(move, state) end)
      |> Map.get(:houses)

    bot_houses =
      santa_bot_moves(moves)
      |> Enum.reduce(state, fn move, state -> process_move(move, state) end)
      |> Map.get(:houses)

    MapSet.union(santa_houses, bot_houses)
    |> Enum.count()
  end

  defp parse_input(input) do
    String.graphemes(input)
  end

  def process_move(move, state) do
    # destructure (with pattern matching)
    %{houses: _houses, position: {x, y}} = state

    case move do
      "^" ->
        new_pos = {x, y + 1}
        update_state(new_pos, state)

      "v" ->
        new_pos = {x, y - 1}
        update_state(new_pos, state)

      ">" ->
        new_pos = {x + 1, y}
        update_state(new_pos, state)

      "<" ->
        new_pos = {x - 1, y}
        update_state(new_pos, state)
    end
  end

  def update_state(pos, state) do
    Map.put(state, :position, pos)
    |> Map.put(:houses, MapSet.put(state.houses, pos))
  end

  def santa_moves(original_moves) do
    Enum.take_every(original_moves, 2)
  end

  def santa_bot_moves(original_moves) do
    Enum.take_every(Enum.drop(original_moves, 1), 2)
  end
end
