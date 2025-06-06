defmodule Year2015.Day03Test do
  alias Year2015.Day03
  use ExUnit.Case
  # use ExUnit.Callbacks

  test "update_state" do
    state = %{
      houses: MapSet.new([{0, 0}]),
      position: {0, 0}
    }

    assert Day03.update_state({0, 0}, state).position == {0, 0}
    assert Day03.update_state({0, 0}, state).houses == mapset([{0, 0}])
    assert Day03.update_state({1, 0}, state).position == {1, 0}
    assert Day03.update_state({1, 0}, state).houses == mapset([{0, 0}, {1, 0}])
  end

  describe "process move" do
    setup [:setup_state]

    test "an up move", context do
      result = Day03.process_move("^", context.state)
      dbg(result)
      assert result.position == {0, 1}
      assert result.houses == mapset([{0, 0}, {0, 1}])
    end

    test "a down move", context do
      assert Day03.process_move("v", context.state).position == {0, -1}
      assert Day03.process_move("v", context.state).houses == mapset([{0, 0}, {0, -1}])
    end

    test "a right move", context do
      assert Day03.process_move(">", context.state).position == {1, 0}
      assert Day03.process_move(">", context.state).houses == mapset([{0, 0}, {1, 0}])
    end

    test "a left move", context do
      assert Day03.process_move("<", context.state).position == {-1, 0}
      assert Day03.process_move("<", context.state).houses == mapset([{0, 0}, {-1, 0}])
    end
  end

  defp setup_state(_context) do
    %{
      state: %{
        houses: mapset([{0, 0}]),
        position: {0, 0}
      }
    }
  end

  defp mapset(list) do
    MapSet.new(list)
  end
end
