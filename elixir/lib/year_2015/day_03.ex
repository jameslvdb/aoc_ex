defmodule Year2015.Day03 do
  def part_1() do
    state = %{
      houses: %{
        {0, 0} => 1
      },
      position: {0, 0}
    }

    final_state =
      InputHelper.input_for(2015, 3)
      |> parse_input()
      |> Enum.reduce(state, fn move, state -> process_move(move, state) end)

    Enum.count(final_state.houses)
  end

  defp parse_input(input) do
    String.graphemes(input)
  end

  def process_move(move, state) do
    # destructure (with pattern matching)
    %{houses: houses, position: {x, y}} = state

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
    |> Map.put(:houses, Map.update(state.houses, pos, 1, &(&1 + 1)))
  end
end
