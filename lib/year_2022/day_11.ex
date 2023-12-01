defmodule Year2022.Day11 do
  def create_monkey(lines) do
  end

  def monkey_number(str) do
    Regex.scan(~r/\d+/, str)
    |> List.flatten()
    |> List.first()
    |> String.to_integer()
  end

  def starting_items(str) do
    Regex.scan(~r/\d+/, str)
    |> List.flatten()
    |> Enum.map(&String.to_integer/1)
  end

  def monkey_operation(str) do
    [operation, number] =
      Regex.scan(~r/([+*\-\/])\s(\w+)/, str)
      |> List.flatten()
      |> Enum.drop(1)

    generate_operation_function(operation, number)
  end

  def test_function(str) do
    divisor = String.split(str)
    |> List.last()
    |> String.to_integer()

    &(rem(&1, divisor))
  end

  def generate_operation_function(operation, number) do
	operation_atom = String.to_atom(operation)

    case number do
	  "old" ->
		fn x -> apply(Kernel, operation_atom, [x, x]) end
      _ ->
        fn x -> apply(Kernel, operation_atom, [x, String.to_integer(number)]) end
    end
  end
end
